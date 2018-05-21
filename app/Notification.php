<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Notification extends Model
{
    protected $primaryKey = 'idnotification';
	protected $table = 'notification';

	public function attendants(){ //memberTuples
		return $this->belongsToMany('App\Member','event_member', 'idevent', 'idmember')->withPivot('isadmin');
	}

	public function getTime(){
		$date = strtotime($this->timestamp);
		$now = strtotime(now());
   		$newDate = $now - $date;
   		return round($newDate / (60 * 60 * 24));
	}
}
