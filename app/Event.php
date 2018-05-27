<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class Event extends Model
{
    protected $primaryKey = 'idevent';
    protected $table = 'event';
	public $timestamps  = false;

    
	public function commentTuples(){
		return $this->hasMany('App\Comment', 'event');
	}

	public function attendants(){ //memberTuples
		return $this->belongsToMany('App\Member','event_member', 'idevent', 'idmember')->withPivot('isadmin');
	}

	public function country(){
		return $this->hasOne('App\Country', 'idcountry', 'idcountry');
	}

	public function ticketTypes(){
        return $this->hasMany('App\TicketType', 'event');
    }

	public function printDate(){
			$start = strtotime($this->startday);
			$end = strtotime($this->endday);
			$startT = strtotime($this->starttime);
			$endT = strtotime($this->endtime);
			if ($start == $end)
					echo date('F d, Y', $start) . ", " . date('H:i', $startT) . ' - ' . date('H:i', $endT);
			else
					echo date('F d, Y', $start) . ", " . date('H:i', $startT) . ' - ' . date('F d, Y', $end) . ", " . date('H:i', $endT);

	}

	public function imagePath(){
		if($this->imagepath == null)
			return 'LINK para imagem null';
		else
			return Storage::url($this->imagepath);
	}

	public function isMemberAdded(){
        $user = Auth::id();

        $eventGuy = DB::table('event_member')->where(
            [
                ['idevent', '=', $this->idevent],
                ['idmember', '=', $user],
            ])->get();

        if(sizeof($eventGuy) > 0)
            return true;
    }
}
