<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Comment extends Model
{
	protected $primaryKey = 'idcomment';
	protected $table = 'comment';

	public function printDate(){
		$date = strtotime($this->timestamp);
        return date('F d, Y', $date) . ", " . date('H:i:s', $date);
	}

	public function printAuthor(){
		return $this->authorTuple()->name;
	}

	public function event(){
		return $this->belongsTo('Event', 'event');
	}

	public function authorTuple(){
		return $this->belongsTo('Member', 'author');
	}
}
