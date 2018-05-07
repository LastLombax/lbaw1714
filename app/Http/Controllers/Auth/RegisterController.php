<?php

	namespace App\Http\Controllers\Auth;

	use App\Member;
	use App\User;
	use App\Country;
	use App\Http\Controllers\Controller;
	use Illuminate\Support\Facades\Validator;
	use Illuminate\Foundation\Auth\RegistersUsers;
	use Symfony\Component\VarDumper\Caster\DateCaster;

	class RegisterController extends Controller
	{
		/*
		|--------------------------------------------------------------------------
		| Register Controller
		|--------------------------------------------------------------------------
		|
		| This controller handles the registration of new users as well as their
		| validation and creation. By default this controller uses a trait to
		| provide this functionality without requiring any additional code.
		|
		*/

		use RegistersUsers;

		/**
		 * Where to redirect users after registration.
		 *
		 * @var string
		 */
		protected $redirectTo = '/';

		/**
		 * Create a new controller instance.
		 *
		 * @return void
		 */
		public function __construct() {
			$this->middleware('guest');
		}

		/**
		 * Get a validator for an incoming registration request.
		 *
		 * @param  array $data
		 * @return \Illuminate\Contracts\Validation\Validator
		 */
		protected function validator(array $data) {
			$messages = [
				'unique' => 'That :attribute is already in use!',
				'max'    => 'The :attribute surpassed the maximum length :max!',
				'email.required' => 'We need to know your e-mail address!',

			];

			return Validator::make($data, [
				'username' => 'required|string|unique:member|min:3|max:255',
				'email' => 'required|string|email|max:255|unique:member',
				'password' => 'required|string|min:6|confirmed',
				'idcountry' => 'required|string|exists:country,name',
			],
				$messages);
		}

		/**
		 * Create a new Member instance after a valid registration.
		 *
		 * @param  array $data
		 * @return \App\Member
		 */
		protected function create(array $data) {
			
			return Member::create([
				'username' => $data['username'],
				'email' => $data['email'],
				'idcountry' => Country::where('name', '=', $data['country'])->first()->idcountry,
				'password' => bcrypt($data['password']),
				'name' => $data['name'],
				'profilepicture' => 'img/defaultMember',
				'registrationdate' => now()->toDateString(),
				'verifiedemail' => false,
				'iswebsiteadmin' => false,
			]);
		}

		protected function showRegistrationForm() {
			return view('auth.register');
		}
	}
