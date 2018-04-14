<?php

	namespace App\Http\Controllers;

	use App\Http\Controllers\Controller;
	use Illuminate\Foundation\Request;

	class EventsController extends Controller
	{
		public function createEventForm(){

			return view('pages.events.create');

		}

		protected function showEvent($id){

			return view('pages.events.event');
		}


	}
