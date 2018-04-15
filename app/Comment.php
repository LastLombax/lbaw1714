<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Comment extends Model
{
	protected $primaryKey = 'idcomment';
	protected $table = 'comment';


	public function event(){
		return $this->belongsTo('Event', 'event');
	}

	public function authorTuple(){
		return $this->belongsTo('Member', 'author');
	}
}
