<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Comment extends Model
{
	protected $primaryKey = 'idcomment';
	protected $table = 'comment';


		public function event(){
			$this->belongsTo('Event');
	}
}
