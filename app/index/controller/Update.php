<?php


namespace app\index\controller;

use think\facade\View;

class Update extends Base
{
    public function index()
    {
        $date = input('date');
        $day = input('day');
        if (empty($date)) {
            $time = strtotime(date('Y-m-d'));
        } else {
            $time = strtotime($date);
        }

        View::assign([
            'day' => $day == null ? -1 : $day,
            'time' => $time,
        ]);
        return view($this->tpl);
    }


}