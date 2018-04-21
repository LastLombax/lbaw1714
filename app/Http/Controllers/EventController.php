<?php

	namespace App\Http\Controllers;

	use App\Event;
	use App\Http\Controllers\Controller;
	use Illuminate\Http\Request;
	use Illuminate\Support\Facades\DB;
	use Illuminate\Support\Facades\Validator;
	use Illuminate\Support\Facades\Gate;

	class EventController extends Controller
	{
		public function index(){
			$events = Event::all();
			return view('pages.events.showEvents')->with('events', $events);
		}

		public function createForm(){

			return view('pages.events.createEvent');

		}

		public function create(Request $request){
			dd($request);
			$this->validator($request->all())->validate();

			$event = new Event();

			$event->name = $request->name;
			$event->description = $request->description;
//			$event->imagepath
			$event->startday = $request->startDate;
			$event->endday = $request->endDate;
			$event->starttime = $request->startTime;
			$event->endtime = $request->endTime;
			$event->country = $request->country;
//			$event->city = $request->
			$event->ispublic = $request->visibility;

			$event->save();

			return view('pages.events.event')->with('event', $event);

		}

		public function show(Event $event){
			return view('pages.events.event')->with('event', $event);
		}

		public function editForm(Event $event){
			return view('pages.events.editEvent')->with('event', $event);
		}

		public function edit(Request $request, Event $event){

			if (Gate::allows('update-event', $event)) {
				$this->validator($request->all())->validate();
			
				$event->name = $request->name;
				$event->description = $request->description;
				//$event->imagepath
				$event->startday = $request->startDate;
				$event->endday = $request->endDate;
				$event->starttime = $request->startTime;
				$event->endtime = $request->endTime;
				$event->country = $request->country;
				//$event->city = $request->
				if ($request->visibility =="public")
					$event->ispublic = true;
				else
					$event->ispublic = false;

				$event->save();
			}

			return view('pages.events.event')->with('event', $event);
		}

		
		public function delete(Event $event){

			if (Gate::allows('update-event', $event)) {

				Event::find($event->idevent)->delete();

				return redirect()->route('homepage');
			}

			else

			 return view('pages.events.event')->with('event', $event);

		}

		/**Asserts the validity of the event's data
		 * @param array $data Event's attributes present in the request
		 * @return boolean
		 */
		protected function validator(array $data) {
//			$messages = [
//				'unique' => 'That :attribue is already in use!',
//				'max'    => 'The :attribute surpassed the maximum length :max!',
//				'email.required' => 'We need to know your e-mail address!',
//
//			];


			return $validate = Validator::make($data, [
				'name' => 'required|string|max:64',
				'description' => 'required|string|max:516',
				'startDate'=> '',
				'startTime' => '',
				'endDay' => '',
				'endTime' => '',
				'ispublic'=> 'boolean',
				'address' => '',
				'lodgingLink' => '',
			]);
			
		}

		//Queries
		public static function upcomingPublicEvents(){
            return Event::where(
                    [
                        ['ispublic', '=', 'true'],
                        ['startday','>=', now()->toDateString()]
                    ]
                )
                ->orderBy('startday', 'ASC')
                ->limit(4)
                ->get();
		}

		public static function upcomingEvents(){
				return Event::where(
								'startday','>=', now()->toDateString()
						)
						->orderBy('startday', 'ASC')
						->limit(4)
						->get();
		}

		public static function topEvents(){ //Mostrar top events, eventos com mais membros que vão
			return DB::select('SELECT count(event_member.idmember) as attendants, event.*
							FROM event_member INNER JOIN event ON event_member.idevent = event.idevent
							GROUP BY(event.idevent)
							ORDER BY attendants DESC LIMIT 2');
		}
        public static function memberTopEvents(){ //Mostrar top events, eventos com mais membros que vão
            return DB::select('SELECT count(event_member.idmember) as attendants, event.*
							FROM event_member INNER JOIN event ON event_member.idevent = event.idevent
							GROUP BY(event.idevent)
							ORDER BY attendants DESC LIMIT 4');
        }

        public static function searchEventByName($selectedName){
            $selected = "%" . $selectedName . "%";

            return Event::where('name','LIKE', $selected)->orderBy('startday', 'ASC')->limit(9)->get();
        }
	}
