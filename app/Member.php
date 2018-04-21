<?php

	namespace App;

	use Illuminate\Notifications\Notifiable;
	use Illuminate\Foundation\Auth\User as Authenticatable;

	class Member extends Authenticatable
	{
		protected $primaryKey = 'idmember';
		protected $table = 'member';


		//Relations
		public function  commentTuples(){
			return $this->hasMany('App\Comment', 'author');
		}
		
		public function  eventTuples(){
			return $this->belongsToMany('App\Event','event_member', 'idmember', 'idevent')->withPivot('isadmin');
		}


		use Notifiable;

		// Don't add create and update timestamps in database.
		public $timestamps  = false;


		/**
		 * The attributes that are mass assignable.
		 *
		 * @var array
		 */
		protected $fillable = [
			'username',
			'email',
			'country',
			'password',
			'name',
			'registrationdate',
			'verifiedemail',
			'iswebsiteadmin',
		];


		/**
		 * The attributes that should be hidden for arrays.
		 *
		 * @var array
		 */
		protected $hidden = [
			'password', 'remember_token',
		];



//		public static function create($array) {
//			dd($array);
//		}


	}
