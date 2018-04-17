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

			return view('pages.events.create');

		}

		public function showEvent(Event $event){
			//Less idiomatic $event = DB::table('event')->find($id);

			//return view('pages.events.event', $event);

			return view('pages.events.event')->with('event', $event);
		}
	}
