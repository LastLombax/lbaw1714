<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Event extends Model
{
    protected $primaryKey = 'idevent';
    protected $table = 'event';

    //Relations
		public function  comments(){
			return $this->hasMany('App\Comment', 'event');
		}

    public function printDate(){
        $start = strtotime($this->startday);
        $end = strtotime($this->endday);
        $startT = strtotime($this->starttime);
        $endT = strtotime($this->endtime);
        if ($start == $end) {
            echo date('F d, Y', $start) . ", " . date('H:i', $startT) . ' - ' . date('H:i', $endT);
        } else {
            echo date('F d, Y', $start) . ", " . date('H:i', $startT) . ' - ' . date('F d, Y', $end) . ", " . date('H:i', $endT);
        }
    }
}
