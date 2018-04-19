<?php

	namespace App\Http\Controllers;

	use App\Event;
	use App\Http\Controllers\Controller;
	use Illuminate\Http\Request;
	use Illuminate\Support\Facades\DB;
	use Illuminate\Support\Facades\Validator;

	class EventController extends Controller
	{
		public function index(){
			$events = Event::all();
			return view('pages.events.showEvents')->with('events', $events);
		}

		public function createEventForm(){

			return view('pages.events.createEvent');

		}

		public function showEvent(Event $event){

			return view('pages.events.event')->with('event', $event);
		}

		public function editForm(Event $event){
			return view('pages.events.editEvent')->with('event', $event);
		}

		public function edit(Request $request, Event $event){

			//$this->validator($request->all())->validate();

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

		//TODO In need of check of permitions
		public function deleteEvent(Event $event){

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


			return Validator::make($data, [
				'name' => 'required|string|max:64',
				'description' => 'required|string|max:516',
				'startDate'=> '',
				'startTime' => '',
				'endDay' => '',
				'endTime' => '',
				'visibility'=> 'boolean',
				'address' => '',
				'lodgingLink' => '',
			]);
		}

		//Queries
		public static function nearbyPublicEvents(){
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

		public static function nearbyEvents(){
				return Event::where(
								'startday','>=', now()->toDateString()
						)
						->orderBy('startday', 'ASC')
						->limit(4)
						->get();
		}


		public static function topEvents(){ //Mostrar top events, eventos com mais membros que vão
			dd(DB::select('SELECT count(event_member.idmember) as attendants, event.*
												FROM event_member INNER JOIN event ON event_member.idevent = event.idevent
												GROUP BY(event.idevent)
												ORDER BY attendants DESC'));
		}
	}
