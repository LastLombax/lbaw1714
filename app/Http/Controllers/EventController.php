<?php

	namespace App\Http\Controllers;

	use App\Event;
	use App\Http\Controllers\Controller;
	use Illuminate\Foundation\Request;

	class EventController extends Controller
	{
		public function index(){
			$events = Event::all();
			return view('pages.events.event')->with('events', $events);
		}

		public function createEventForm(){

			return view('pages.events.createEvent');

		}

		public function showEvent(Event $event){

			return view('pages.events.editEvent')->with('event', $event);
		}

		public function editEvent(Event $event){
			dd($event);
			return view('pages.events.event')->with('event', $event);
		}


	}
