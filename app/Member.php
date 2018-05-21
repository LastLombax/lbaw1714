<?php

	namespace App;

	use Illuminate\Notifications\Notifiable;
	use Illuminate\Foundation\Auth\User as Authenticatable;
	use Illuminate\Support\Facades\Storage;
	use Illuminate\Contracts\Auth\CanResetPassword;
	use  Illuminate\Auth\Passwords\CanResetPassword as resetPass;
	
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

		public function isadmin(){
			return $this->iswebsiteadmin;
		}	

		public function printDate(){
			$birthdate = strtotime($this->birthdate);
		    echo date('F d, Y', $birthdate);

/*		public function friend($member){
			//return $
		}
	
*/
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
			'idcountry',
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

		//-----------RELATIONS--------------
		public function country(){
			return $this->hasOne('App\Country', 'idcountry','idcountry');
		}
		//-----------------------------------



		public function imagePath(){
			if($this->profilepicture == null)
				return Storage::url('img/member/defaultMember.png');
			else
				return Storage::url($this->profilepicture);
		}

//		public static function create($array) {
//			dd($array);
//		}


	}
