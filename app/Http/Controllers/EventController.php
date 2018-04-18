<?php

	namespace App\Http\Controllers;

	use App\Event;
	use App\Http\Controllers\Controller;
	use Illuminate\Foundation\Request;

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

		public function editEventForm(Event $event){
			return view('pages.events.editEvent')->with('event', $event);
		}

		/*public function editEvent(Event $event){

			return view('pages.events.event')->with('event', $event);
		}*/

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

		public function deleteEvent(Event $event){

			return view('pages.events.event')->with('event', $event);
		}

//		public static function topEvents(){ Mostrar top events, eventos com mais membros que vão
//			return Event:: Event::memberTuples())->orderBy('attendants', 'DESC')
//				->limit(4)
//				->get();
//		}


	}
