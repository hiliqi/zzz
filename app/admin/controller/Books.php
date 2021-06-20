<?php


namespace app\admin\controller;

use app\model\Book;
use think\db\exception\ModelNotFoundException;
use think\facade\View;
use app\model\Area;
use Overtrue\Pinyin\Pinyin;
use think\facade\Db;
use app\model\Chapter;
use app\model\Photo;

class Books extends BaseAdmin
{
    public function index()
    {
        return view();
    }

    public function list()
    {
        $status = intval(input('status'));
        $page = intval(input('page'));
        $limit = intval(input('limit'));
        if ($status == 1) {
            $data = Book::order('id', 'desc');
        } else {
            $data = Book::onlyTrashed()->order('id', 'desc');
        }

        $count = $data->count();
        $books = $data->limit(($page - 1) * $limit, $limit)->select();

        foreach ($books as &$book) {
            $book['area'] = Area::where('id', '=', $book['area_id'])->column('area_name');
            if (substr($book->cover_url, 0, 4) === "http") {

            } else {
                $book->cover_url = $this->img_domain . $book->cover_url;
            }
            if (substr($book->banner_url, 0, 4) === "http") {

            } else {
                $book->banner_url = $this->img_domain . $book->banner_url;
            }
        }
        return json([
            'code' => 0,
            'msg' => '',
            'count' => $count,
            'data' => $books
        ]);
    }

    public function edit()
    {
        $data = request()->param();
        try {
            $book = Book::findOrFail($data['id']);
            if (substr($book->cover_url, 0, 4) === "http") {

            } else {
                $book->cover_url = $this->img_domain . $book->cover_url;
            }
            if (request()->isPost()) {
                $result = $book->save($data);
                if ($result) {
                    return json(['err' => 0, 'msg' => '修改成功']);
                } else {
                    return json(['err' => 1, 'msg' => '修改失败']);
                }
            } else {
                $areas = Area::select();
                View::assign([
                    'book' => $book,
                    'areas' => $areas
                ]);
                return view();
            }
        } catch (ModelNotFoundException $e) {
            return json(['err' => 0, 'msg' => $e->getMessage()]);
        }
    }

    public function upload()
    {
        if (is_null(request()->file())) {
            return json([
                'err' => 1
            ]);
        } else {
            $cover = request()->file('file');
            $dir = 'book/cover';
            $savename = str_replace('\\', '/',
                \think\facade\Filesystem::disk('public')->putFile($dir, $cover));
            return json([
                'err' => 0,
                'msg' => '',
                'img' => '/static/upload/' . $savename
            ]);
        }
    }

    public function search()
    {
        $name = input('book_name');
        $where = [
            ['book_name', 'like', '%' . $name . '%']
        ];
        $page = intval(input('page'));
        $limit = intval(input('limit'));
        $data = Book::where($where);
        $count = $data->count();
        $books = $data->limit(($page - 1) * $limit, $limit)->order('id', 'desc')->select();

        foreach ($books as &$book) {
            $book['area'] = Area::where('id', '=', $book['area_id'])->column('area_name');
            if (substr($book->cover_url, 0, 4) === "http") {

            } else {
                $book->cover_url = $this->img_domain . $book->cover_url;
            }
        }
        return json([
            'code' => 0,
            'msg' => '',
            'count' => $count,
            'data' => $books
        ]);
    }

    public function disable()
    {
        $id = input('id');
        if (empty($id) || is_null($id)) {
            return ['err' => 1, 'msg' => 'id不能为空'];
        }
        try {
            $book = Book::findOrFail($id);
            $result = $book->delete();
            if ($result) {
                return json(['err' => 0]);
            } else {
                return json(['err' => 1]);
            }
        } catch (ModelNotFoundException $e) {
            return json(['err' => 1, 'msg' => $e->getMessage()]);
        }
    }

    public function enable()
    {
        $id = input('id');
        if (empty($id) || is_null($id)) {
            return ['err' => 1, 'msg' => 'id不能为空'];
        }
        try {
            $book = Book::onlyTrashed()->findOrFail($id);
            $result = $book->restore();
            if ($result) {
                return json(['err' => 0]);
            } else {
                return json(['err' => 1]);
            }
        } catch (ModelNotFoundException $e) {
            return json(['err' => 1, 'msg' => $e->getMessage()]);
        }
    }

    public function disabled()
    {
        return view();
    }

    public function payment()
    {
        if (request()->isPost()) {
            $data = request()->param();
            $start_pay = (int)$data['start_pay'];
            $money = (double)$data['money'];
            $start_id = (int)$data['start_id'];
            $last_id = (int)$data['last_id'];
            $sql = 'UPDATE ' . $this->prefix . 'book SET start_pay=' . $start_pay .
                ',money=' . $money . ' WHERE id>=' . $start_id . ' and id<=' . $last_id;

            Db::query($sql);
            return json(['err' => 0, 'msg' => '批量设置成功']);
        }
        return view();
    }

    public function delete()
    {
        $id = input('id');
        try {
            $book = Book::withTrashed()->findOrFail($id);
            $chapters = Chapter::where('book_id', '=', $id)->select(); //按漫画id查找所有章节
            foreach ($chapters as $chapter) {
                $pics = Photo::where('chapter_id', '=', $chapter->id)->select(); //按章节id查找所有图片
                foreach ($pics as $pic) {
                    $pic->delete(); //删除图片
                }
                $chapter->delete(); //删除章节
            }
            $result = $book->delete(true);
            if ($result) {
                return json(['err' => 0, 'msg' => '删除成功']);
            } else {
                return json(['err' => 1, 'msg' => '删除失败']);
            }

        } catch (ModelNotFoundException $e) {
            return json(['err' => 1, 'msg' => $e->getMessage()]);
        }
    }

    public function deleteAll()
    {
        $ids = input('ids');
        foreach ($ids as $id) {
            $chapters = Chapter::where('book_id', '=', $id)->select(); //按漫画id查找所有章节
            foreach ($chapters as $chapter) {
                $pics = Photo::where('chapter_id', '=', $chapter->id)->select(); //按章节id查找所有图片
                foreach ($pics as $pic) {
                    $pic->delete(); //删除图片
                }
                $chapter->delete(); //删除章节
            }
        }
        Book::destroy($ids, true);
    }

    protected function convert($str)
    {
        $pinyin = new Pinyin();
        $name_format = config('seo.name_format');
        switch ($name_format) {
            case 'pure':
                $arr = $pinyin->convert($str);
                $str = implode($arr, '');
                halt($str);
                break;
            case 'abbr':
                $str = $pinyin->abbr($str);
                break;
            default:
                $str = $pinyin->convert($str);
                break;
        }
        return $str;
    }
}