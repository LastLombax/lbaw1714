<?php

	namespace App\Http\Controllers\Events;

	use App\Http\Controllers\Controller;

	use Illuminate\Foundation\Request;

	class EventsController extends Controller
	{
		
		public function createEventForm(){

			return view('events.create');

		}
	

	}
