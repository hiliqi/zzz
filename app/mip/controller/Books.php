<?php


namespace app\mip\controller;


use app\model\Book;
use app\model\Comments;
use app\model\UserFavor;
use app\service\BookService;
use think\db\exception\DataNotFoundException;
use think\db\exception\ModelNotFoundException;
use think\facade\Db;
use think\facade\View;
use app\common\RedisHelper;

class Books extends Base
{
    public function initialize()
    {
        parent::initialize();
        $this->bookService = app('bookService');
    }

    public function index($id)
    {
        //$id = input('id');
        $book = cache('book:' . $id);
        $tags = cache('tags:book:' . $id);
        if ($book == false) {
            try {
                $book_end_point = config('seo.book_end_point');
                if ($book_end_point == 'id') {

                    $book = Book::with(['chapters' => function ($query) {
                        $query->order('chapter_order');
                    }])->findOrFail($id);
                } else {
                    $book = Book::with(['chapters' => function ($query) {
                        $query->order('chapter_order');
                    }])->where('unique_id', '=', $id)->findOrFail();
                }
            } catch (DataNotFoundException $e) {
                abort(404, $e->getMessage());
            } catch (ModelNotFoundException $e) {
                abort(404, $e->getMessage());
            }
            $tags = [];
            if (!empty($book->tags) || is_null($book->tags)) {
                $tags = explode('|', $book->tags);
            }
            cache('book:' . $id, $book, null, 'redis');
            cache('tags:book:' . $id, $tags, null, 'redis');
        }
        $redis = RedisHelper::GetInstance();
        $day = date("Y-m-d", time());
        //以当前日期为键，增加点击数
        $redis->zIncrBy('click:' . $day, 1, $book->id);

        $recommand = cache('randBooks:' . $book->tags);
        if (!$recommand) {
            $recommand = $this->bookService->getRecommand($book->tags, $this->end_point);
            cache('randBooks:' . $book->tags, $recommand, null, 'redis');
        }

        $start = cache('bookStart:' . $id);
        if ($start == false) {
            $db = Db::query('SELECT id FROM ' . $this->prefix . 'chapter WHERE book_id = ' . $book->id . ' ORDER BY id LIMIT 1');
            $start = $db ? $db[0]['id'] : -1;
            cache('bookStart:' . $id, $start, null, 'redis');
        }

        $comments = $this->getComments($book->id);

        $isfavor = 0;
        if (!is_null($this->uid)) {
            $where[] = ['user_id', '=', $this->uid];
            $where[] = ['book_id', '=', $book->id];
            try {
                $userfavor = UserFavor::where($where)->findOrFail();
                $isfavor = 1;
            } catch (DataNotFoundException $e) {
            } catch (ModelNotFoundException $e) {
            }
        }

        $start_pay = cache('maxChapterOrder:' . $book->id);
        if (!$start_pay) {
            if ($book->start_pay >= 0) {
                $start_pay = $book->start_pay; //如果是正序，则开始付费章节就是设置的
            } else { //如果是倒序付费设置
                $abs = abs($book->start_pay) - 1; //取得倒序的绝对值，比如-2，则是倒数第2章开始付费
                $max_chapter_order = Db::query("SELECT MAX(chapter_order) as max FROM " . $this->prefix . "chapter WHERE book_id=:id",
                    ['id' => $book->id])[0]['max'];
                cache('maxChapterOrder:' . $id, $max_chapter_order);
                $start_pay = (float)$max_chapter_order - $abs; //计算出起始付费章节
            }
        }

        $clicks = cache('bookClicks:' . $book->id);
        if (!$clicks) {
            $clicks = $this->bookService->getClicks($book->id, $this->prefix);
            cache('bookClicks:' . $book->id, $clicks);
        }

        View::assign([
            'book' => $book,
            'tags' => $tags,
            'start' => $start,
            'recommand' => $recommand,
            'header_title' => $book->book_name,
            'isfavor' => $isfavor,
            'comments' => $comments,
            'start_pay' => $start_pay,
            'clicks' => $clicks,
            'c_url' => config('site.mobile_domain').'/'.BOOKCTRL.'/'.$book->id
        ]);
        return view($this->tpl);
    }

    private function getComments($book_id)
    {
        $comments = cache('comments:' . $book_id);
        if (!$comments) {
            $comments = Comments::with('user')->where('book_id', '=', $book_id)
                ->order('create_time', 'desc')->limit(0, 5)->select();
            cache('comments:' . $book_id, $comments);
        }
        return $comments;
    }
}