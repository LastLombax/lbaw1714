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
			$event = DB::select('select * from event where idevent = ?', $id);
			return view('pages.events.event');
		}


	}
