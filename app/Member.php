<?php

	namespace App;

	use Illuminate\Database\Eloquent\Model;

	class Member extends Model
	{
		protected $primaryKey = 'idmember';
		protected $table = 'member';

		//Relations
		public function  commentTuples(){
			return $this->hasMany('App\Comment', 'author');
		}
	}
