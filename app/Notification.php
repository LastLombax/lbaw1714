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
}
