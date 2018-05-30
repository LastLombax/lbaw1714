<?php

	namespace App\Http\Controllers;

	use App\Country;
    use App\Event;
	use App\Http\Controllers\Controller;
	use App\Member;
    use App\TicketType;
    use Auth;
    use http\Env\Response;
    use Illuminate\Http\Request;
	use Illuminate\Support\Facades\DB;
	use Illuminate\Support\Facades\Validator;
	use Illuminate\Support\Facades\Gate;

	class AdminController extends Controller
	{
		public function index(){
			return view('pages.administration.administration');
		}

		public function createForm(){

			return view('pages.events.createEvent');

		}

		public function create(Request $request){
		    $this->validator($request->all())->validate();
			$event = new Event();

			$event->name = $request->name;
			$event->description = $request->description;

			$event->startday = $request->startDate;
			$event->endday = $request->endDate;
			$event->starttime = $request->startTime;
			$event->endtime = $request->endTime;
			$event->idcountry = Country::where('name', '=',  $request->country)->first()->idcountry;
			$event->address = $request->address;
			$event->city = $request->city;
			$event->ispublic = $request->visibility;

			$event->save();

			if($request->hasFile('eventImage')) {
				$imgType = $request->file('eventImage')->getMimeType();
				$imgType = '.' . substr($imgType, strpos($imgType, '/') + 1);

				$event->imagepath = 'img/event/' . $event->idevent . $imgType;

				$event->save();

				$request->file('eventImage')->storeAs('public/img/event', $event->idevent . $imgType);
			}

			DB::table('event_member')->insert(
				[	'idevent' => $event->idevent,
					'idmember' => Auth::user()->idmember,
					'isadmin' => true,
				]
			);

			return redirect()->route('event', $event->idevent);
		}

		public function show(Event $event){
			return view('pages.events.event')->with('event', $event);
		}

		public function editForm(Event $event){
			return view('pages.events.editEvent')->with('event', $event);
		}

		public function edit(Request $request, Event $event){
			if (Gate::allows('event-admin', $event)) {

				$this->validator($request->all())->validate();

				$event->name = $request->name;
				$event->description = $request->description;

				if($request->hasFile('eventImage')) {
					$imgType = $request->file('eventImage')->getMimeType();
					$imgType = '.' . substr($imgType, strpos($imgType, '/') + 1);

					$event->imagepath = 'img/event/' . $event->idevent . $imgType;

					$event->save();

					$request->file('eventImage')->storeAs('public/img/event', $event->idevent . $imgType);
				}

				$event->startday = $request->startDate;
				$event->endday = $request->endDate;
				$event->starttime = $request->startTime;
				$event->endtime = $request->endTime;
				$event->idcountry = Country::where('name', '=', $request->country)->first()->idcountry;
				$event->city = $request->city;
				$event->address = $request->address;

				$event->ispublic = $request->visibility;

				$event->save();
			}

			return view('pages.events.event')->with('event', $event);
		}


		public function delete(Event $event){

			if (Gate::allows('event-admin', $event)) {

				//Event::find($event->idevent)->delete();
				try {
					$event->delete();
				} catch (\Exception $e) {
					echo "Error in delete Event";
				}

				return redirect()->route('homepage');
			}

			else

			 return view('pages.events.event')->with('event', $event);

		}

		protected function inviteMember(Request $request, Event $event){
				$username = $request->usernameField;
				$idEvent = $event->idevent;
				$user = Member::where('username', '=', $username)->first()->idmember;
				if($user != null){
				return DB::insert('INSERT INTO notification VALUES
					('. now() . ' , event, null, ?, "You were invited to" , null, ?)'
					, [idmember, $idEvent]);
				};

				return Response(404);
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

			$validate = Validator::make($data, [
				'name' => 'required|string|max:64',
				'description' => 'required|string|max:516',
				'startDate'=> 'date_format:"Y-m-d',
				'startTime' => '',
				'endDate' => 'date_format:"Y-m-d|after_or_equal:startDate',
				'endTime' => '',
				'country' => 'required|string|exists:country,name',
				'ispublic'=> 'boolean',
				'address'=> 'nullable|string|max:50',
				'lodgingLink' => 'nullable',
			]);

            return $validate;

		}

        public static function basicSearch(Request $request){
            if (!isset($request->search))
                $events = Event::where('ispublic', '=','true');
            else
                 $events = Event::whereRaw('fts_vector @@ to_tsquery(\'portuguese\', ?) AND ispublic = true', $request->search);

            $events = $events->orderBy('startday', 'DESC')->get();

            return view('pages.events.viewEventsBasic')->with('events', $events);

        }

        public static function searchEventType1($searchField, $selectedRange, $selectedCountry, $minPrice, $maxPrice, $selectedOrder){
            if($searchField == "")
            {
                if($selectedOrder == "chrono")
                {
                    if($selectedRange == "all")
                    {
                        return DB::select('SELECT e1.*
	                            FROM event_member, event e1
                                INNER JOIN LATERAL(
                                    SELECT tickettype.event
                                    FROM tickettype
                                    WHERE e1.idevent = tickettype.event
                                    AND tickettype.price BETWEEN ? AND ?
                                ) c2 ON true

                                INNER JOIN LATERAL(
                                    SELECT *
                                    FROM event_member em
                                    WHERE
                                    em.idevent = e1.idevent
                                ) c3 ON true

                                WHERE e1.startday >= \''. now()->toDateString() .'\'
                                AND e1.idcountry = ?
                                GROUP BY(e1.idevent)
                                ORDER BY e1.startday DESC LIMIT 9', [$minPrice, $maxPrice, $selectedCountry]);
                    }
                    else
                    {
                        $user = Auth::id();

                        return DB::select('SELECT e1.*
	                            FROM event_member, event e1
                                INNER JOIN LATERAL(
                                    SELECT tickettype.event
                                    FROM tickettype
                                    WHERE e1.idevent = tickettype.event
                                    AND tickettype.price BETWEEN ? AND ?
                                ) c2 ON true

                                INNER JOIN LATERAL(
                                    SELECT *
                                    FROM event_member em
                                    WHERE
                                    em.idevent = e1.idevent
                                ) c3 ON true

                                WHERE e1.startday >= \''. now()->toDateString() .'\'
                                AND e1.idcountry = ?
                                AND event_member.idevent = e1.idevent
                                AND event_member.idmember = ?
                                AND event_member.isadmin = true
                                GROUP BY(e1.idevent)
                                ORDER BY e1.startday DESC LIMIT 9', [$minPrice, $maxPrice, $selectedCountry, $user]);
                    }
                }
                else
                {
                    if($selectedRange == "all") //done
                    {
                        return DB::select('SELECT count(event_member.idmember) as attendants, e1.*
	                            FROM event_member, event e1
                                INNER JOIN LATERAL(
                                    SELECT tickettype.event
                                    FROM tickettype
                                    WHERE e1.idevent = tickettype.event
                                    AND tickettype.price BETWEEN ? AND ?
                                ) c2 ON true

                                INNER JOIN LATERAL(
                                    SELECT *
                                    FROM event_member em
                                    WHERE
                                    em.idevent = e1.idevent
                                ) c3 ON true

                                WHERE e1.idcountry = ?
                                GROUP BY(e1.idevent)
                                ORDER BY attendants DESC LIMIT 9', [$minPrice, $maxPrice, $selectedCountry]);
                    }
                    else //done
                    {
                        $user = Auth::id();

                        return DB::select('SELECT count(event_member.idmember) as attendants, e1.*
	                            FROM event_member, event e1
                                INNER JOIN LATERAL(
                                    SELECT tickettype.event
                                    FROM tickettype
                                    WHERE e1.idevent = tickettype.event
                                    AND tickettype.price BETWEEN ? AND ?
                                ) c2 ON true

                                INNER JOIN LATERAL(
                                    SELECT *
                                    FROM event_member em
                                    WHERE
                                    em.idevent = e1.idevent
                                ) c3 ON true

                                WHERE e1.idcountry = ?
                                AND event_member.idevent = e1.idevent
                                AND event_member.idmember = ?
                                AND event_member.isadmin = true
                                GROUP BY(e1.idevent)
                                ORDER BY attendants DESC LIMIT 9', [$minPrice, $maxPrice, $selectedCountry, $user]);
                    }
                }
            }
            else
            {
                $selected = "%" . $searchField . "%";

                if($selectedOrder == "chrono")
                {
                    if($selectedRange == "all") //done
                    {
                        return DB::select('SELECT e1.*
	                            FROM event_member, event e1
                                INNER JOIN LATERAL(
                                    SELECT tickettype.event
                                    FROM tickettype
                                    WHERE e1.idevent = tickettype.event
                                    AND tickettype.price BETWEEN ? AND ?
                                ) c2 ON true

                                INNER JOIN LATERAL(
                                    SELECT *
                                    FROM event_member em
                                    WHERE
                                    em.idevent = e1.idevent
                                ) c3 ON true

                                WHERE fts_vector @@ to_tsquery(\'portuguese\', ?)
                                AND e1.startday >= \''. now()->toDateString() .'\'
                                AND e1.idcountry = ?
                                GROUP BY(e1.idevent)
                                ORDER BY e1.startday DESC LIMIT 9', [$minPrice, $maxPrice, $selected, $selectedCountry]);
                    }
                    else //done
                    {
                        $user = Auth::id();

                        return DB::select('SELECT e1.*
	                            FROM event_member, event e1
                                INNER JOIN LATERAL(
                                    SELECT tickettype.event
                                    FROM tickettype
                                    WHERE e1.idevent = tickettype.event
                                    AND tickettype.price BETWEEN ? AND ?
                                ) c2 ON true

                                INNER JOIN LATERAL(
                                    SELECT *
                                    FROM event_member em
                                    WHERE
                                    em.idevent = e1.idevent
                                ) c3 ON true

                                WHERE fts_vector @@ to_tsquery(\'portuguese\', ?)
                                AND e1.startday >= \''. now()->toDateString() .'\'
                                AND e1.idcountry = ?
                                AND event_member.idevent = e1.idevent
                                AND event_member.idmember = ?
                                AND event_member.isadmin = true
                                GROUP BY(e1.idevent)
                                ORDER BY e1.startday DESC LIMIT 9', [$minPrice, $maxPrice, $selected, $selectedCountry, $user]);

                    }
                }
                else //done
                {
                    if($selectedRange == "all")
                    {
                        return DB::select('SELECT count(event_member.idmember) as attendants, e1.*
	                            FROM event_member, event e1
                                INNER JOIN LATERAL(
                                    SELECT tickettype.event AS ticketType
                                    FROM tickettype
                                    WHERE e1.idevent = tickettype.event
                                    AND tickettype.price BETWEEN ? AND ?
                                ) c2 ON true

                                INNER JOIN LATERAL(
                                    SELECT *
                                    FROM event_member em
                                    WHERE
                                    em.idevent = e1.idevent
                                ) c3 ON true

                                WHERE fts_vector @@ to_tsquery(\'portuguese\', ?)
                                AND e1.idcountry = ?
                                GROUP BY(e1.idevent)
                                ORDER BY attendants DESC LIMIT 9', [$minPrice, $maxPrice, $selected, $selectedCountry]);
                    }
                    else //done
                    {
                        $user = Auth::id();

                        return DB::select('SELECT count(event_member.idmember) as attendants, e1.*
	                            FROM event_member, event e1
                                INNER JOIN LATERAL(
                                    SELECT tickettype.event
                                    FROM tickettype
                                    WHERE e1.idevent = tickettype.event
                                    AND tickettype.price BETWEEN ? AND ?
                                ) c2 ON true

                                INNER JOIN LATERAL(
                                    SELECT *
                                    FROM event_member em
                                    WHERE
                                    em.idevent = e1.idevent
                                ) c3 ON true

                                WHERE fts_vector @@ to_tsquery(\'portuguese\', ?)
                                AND e1.idcountry = ?
                                AND event_member.idevent = e1.idevent
                                AND event_member.idmember = ?
                                AND event_member.isadmin = true
                                GROUP BY(e1.idevent)
                                ORDER BY attendants DESC LIMIT 9', [$minPrice, $maxPrice, $selected, $selectedCountry, $user]);
                    }
                }
            }
        }
        public static function searchEventType2($searchField, $selectedRange, $selectedCountry, $selectedOrder){
            if($searchField == "")
            {
                if($selectedOrder == "chrono")
                {
                    if($selectedRange == "all")
                    {
                        return Event::where([
                            ['startday','>=', now()->toDateString()],
                            ['idcountry','=', $selectedCountry]

                        ])
                            ->orderBy('startday', 'ASC')
                            ->limit(9)
                            ->get();
                    }
                    else
                    {
                        $user = Auth::id();

                        return DB::select('SELECT *
                                FROM event_member INNER JOIN event ON event_member.idevent = event.idevent
                                WHERE event_member.idevent = event.idevent
                                AND event_member.idmember = ?
                                AND event_member.isadmin = true
                                AND event.startday >= \''. now()->toDateString() .'\'
                                AND event.idcountry = ?
                                ORDER BY event.startday ASC LIMIT 9', [$user, $selectedCountry]);
                    }
                }
                else
                {
                    if($selectedRange == "all")
                    {
                        return DB::select('SELECT count(event_member.idmember) as attendants, event.*
                                FROM event_member INNER JOIN event ON event_member.idevent = event.idevent
                                WHERE event.idcountry = ?
                                GROUP BY(event.idevent)
                                ORDER BY attendants DESC LIMIT 9', [$selectedCountry]);
                    }
                    else
                    {
                        $user = Auth::id();

                        return DB::select('SELECT count(event_member.idmember) as attendants, event.*
                                FROM event_member INNER JOIN event ON event_member.idevent = event.idevent
                                WHERE event.idevent = event_member.idevent
                                AND event_member.idmember = ?
                                AND event_member.isadmin = true
                                AND event.idcountry = ?
                                GROUP BY(event.idevent)
                                ORDER BY attendants DESC LIMIT 9', [$user, $selectedCountry]);
                    }
                }
            }
            else
            {
                $selected = "%" . $searchField . "%";

                if($selectedOrder == "chrono")
                {
                    if($selectedRange == "all")
                    {
                        return Event::where(
                            [
                                ['name','ILIKE', $selected],
                                ['startday','>=', now()->toDateString()],
                                ['idcountry','=', $selectedCountry]
                            ]
                        )
                            ->orderBy('startday', 'ASC')
                            ->limit(9)
                            ->get();
                    }
                    else
                    {
                        $user = Auth::id();

                        return DB::select('SELECT event.*
                                FROM event_member INNER JOIN event ON event_member.idevent = event.idevent
                                WHERE fts_vector @@ to_tsquery(\'portuguese\', ?)
                                AND event_member.idevent = event.idevent
                                AND event_member.idmember = ?
                                AND event_member.isadmin = true
                                AND event.startday >= \''. now()->toDateString() .'\'
                                AND event.idcountry = ?
                                GROUP BY(event.idevent)
                                ORDER BY event.startday DESC LIMIT 9', [$selected, $user, $selectedCountry]);
                    }
                }
                else
                {
                    if($selectedRange == "all")
                    {
                        return DB::select('SELECT count(event_member.idmember) as attendants, event.*
                                FROM event_member INNER JOIN event ON event_member.idevent = event.idevent
                                WHERE fts_vector @@ to_tsquery(\'portuguese\', ?)
                                AND event.idcountry = ?
                                GROUP BY(event.idevent)
                                ORDER BY attendants DESC LIMIT 9', [$selected, $selectedCountry]);
                    }
                    else
                    {
                        $user = Auth::id();

                        return DB::select('SELECT count(event_member.idmember) as attendants, event.*
                                FROM event_member INNER JOIN event ON event_member.idevent = event.idevent
                                WHERE fts_vector @@ to_tsquery(\'portuguese\', ?)
                                AND event.idevent = event_member.idevent
                                AND event_member.idmember = ?
                                AND event_member.isadmin = true
                                AND event.idcountry = ?
                                GROUP BY(event.idevent)
                                ORDER BY attendants DESC LIMIT 9', [$selected, $user, $selectedCountry]);
                    }
                }
            }
        }
        public static function searchEventType3($searchField, $selectedRange, $minPrice, $maxPrice, $selectedOrder){
            if($searchField == "")
            {
                if($selectedOrder == "chrono")
                {
                    if($selectedRange == "all")
                    {
                        return DB::select('SELECT e1.*
	                            FROM event_member, event e1
                                INNER JOIN LATERAL(
                                    SELECT tickettype.event
                                    FROM tickettype
                                    WHERE e1.idevent = tickettype.event
                                    AND tickettype.price BETWEEN ? AND ?
                                ) c2 ON true

                                INNER JOIN LATERAL(
                                    SELECT *
                                    FROM event_member em
                                    WHERE
                                    em.idevent = e1.idevent
                                ) c3 ON true

                                WHERE e1.startday >= \''. now()->toDateString() .'\'
                                GROUP BY(e1.idevent)
                                ORDER BY e1.startday DESC LIMIT 9', [$minPrice, $maxPrice]);
                    }
                    else
                    {
                        $user = Auth::id();

                        return DB::select('SELECT e1.*
	                            FROM event_member, event e1
                                INNER JOIN LATERAL(
                                    SELECT tickettype.event
                                    FROM tickettype
                                    WHERE e1.idevent = tickettype.event
                                    AND tickettype.price BETWEEN ? AND ?
                                ) c2 ON true

                                INNER JOIN LATERAL(
                                    SELECT *
                                    FROM event_member em
                                    WHERE
                                    em.idevent = e1.idevent
                                ) c3 ON true

                                WHERE e1.startday >= \''. now()->toDateString() .'\'
                                AND event_member.idevent = e1.idevent
                                AND event_member.idmember = ?
                                AND event_member.isadmin = true
                                GROUP BY(e1.idevent)
                                ORDER BY e1.startday DESC LIMIT 9', [$minPrice, $maxPrice, $user]);
                    }
                }
                else
                {
                    if($selectedRange == "all") //done
                    {
                        return DB::select('SELECT count(event_member.idmember) as attendants, e1.*
	                            FROM event_member, event e1
                                INNER JOIN LATERAL(
                                    SELECT tickettype.event
                                    FROM tickettype
                                    WHERE e1.idevent = tickettype.event
                                    AND tickettype.price BETWEEN ? AND ?
                                ) c2 ON true

                                INNER JOIN LATERAL(
                                    SELECT *
                                    FROM event_member em
                                    WHERE
                                    em.idevent = e1.idevent
                                ) c3 ON true

                                GROUP BY(e1.idevent)
                                ORDER BY attendants DESC LIMIT 9', [$minPrice, $maxPrice]);
                    }
                    else //done
                    {
                        $user = Auth::id();

                        return DB::select('SELECT count(event_member.idmember) as attendants, e1.*
	                            FROM event_member, event e1
                                INNER JOIN LATERAL(
                                    SELECT tickettype.event
                                    FROM tickettype
                                    WHERE e1.idevent = tickettype.event
                                    AND tickettype.price BETWEEN ? AND ?
                                ) c2 ON true

                                INNER JOIN LATERAL(
                                    SELECT *
                                    FROM event_member em
                                    WHERE
                                    em.idevent = e1.idevent
                                ) c3 ON true

                                WHERE event_member.idevent = e1.idevent
                                AND event_member.idmember = ?
                                AND event_member.isadmin = true
                                GROUP BY(e1.idevent)
                                ORDER BY attendants DESC LIMIT 9', [$minPrice, $maxPrice, $user]);
                    }
                }
            }
            else
            {
                $selected = "%" . $searchField . "%";

                if($selectedOrder == "chrono")
                {
                    if($selectedRange == "all") //done
                    {
                        return DB::select('SELECT e1.*
	                            FROM event_member, event e1
                                INNER JOIN LATERAL(
                                    SELECT tickettype.event
                                    FROM tickettype
                                    WHERE e1.idevent = tickettype.event
                                    AND tickettype.price BETWEEN ? AND ?
                                ) c2 ON true

                                INNER JOIN LATERAL(
                                    SELECT *
                                    FROM event_member em
                                    WHERE
                                    em.idevent = e1.idevent
                                ) c3 ON true

                                WHERE fts_vector @@ to_tsquery(\'portuguese\', ?)
                                AND e1.startday >= \''. now()->toDateString() .'\'
                                GROUP BY(e1.idevent)
                                ORDER BY e1.startday DESC LIMIT 9', [$minPrice, $maxPrice, $selected]);
                    }
                    else //done
                    {
                        $user = Auth::id();

                        return DB::select('SELECT e1.*
	                            FROM event_member, event e1
                                INNER JOIN LATERAL(
                                    SELECT tickettype.event
                                    FROM tickettype
                                    WHERE e1.idevent = tickettype.event
                                    AND tickettype.price BETWEEN ? AND ?
                                ) c2 ON true

                                INNER JOIN LATERAL(
                                    SELECT *
                                    FROM event_member em
                                    WHERE
                                    em.idevent = e1.idevent
                                ) c3 ON true

                                WHERE fts_vector @@ to_tsquery(\'portuguese\', ?)
                                AND e1.startday >= \''. now()->toDateString() .'\'
                                AND event_member.idevent = e1.idevent
                                AND event_member.idmember = ?
                                AND event_member.isadmin = true
                                GROUP BY(e1.idevent)
                                ORDER BY e1.startday DESC LIMIT 9', [$minPrice, $maxPrice, $selected, $user]);

                    }
                }
                else //done
                {
                    if($selectedRange == "all")
                    {
                        return DB::select('SELECT count(event_member.idmember) as attendants, e1.*
	                            FROM event_member, event e1
                                INNER JOIN LATERAL(
                                    SELECT tickettype.event AS ticketType
                                    FROM tickettype
                                    WHERE e1.idevent = tickettype.event
                                    AND tickettype.price BETWEEN '.$minPrice.' AND '.$maxPrice.'
                                ) c2 ON true

                                INNER JOIN LATERAL(
                                    SELECT *
                                    FROM event_member em
                                    WHERE
                                    em.idevent = e1.idevent
                                ) c3 ON true

                                WHERE fts_vector @@ to_tsquery(\'portuguese\', ?)
                                GROUP BY(e1.idevent)
                                ORDER BY attendants DESC LIMIT 9', [$minPrice, $maxPrice, $selected]);
                    }
                    else //done
                    {
                        $user = Auth::id();

                        return DB::select('SELECT count(event_member.idmember) as attendants, e1.*
	                            FROM event_member, event e1
                                INNER JOIN LATERAL(
                                    SELECT tickettype.event
                                    FROM tickettype
                                    WHERE e1.idevent = tickettype.event
                                    AND tickettype.price BETWEEN ? AND ?
                                ) c2 ON true

                                INNER JOIN LATERAL(
                                    SELECT *
                                    FROM event_member em
                                    WHERE
                                    em.idevent = e1.idevent
                                ) c3 ON true

                                WHERE fts_vector @@ to_tsquery(?)
                                AND event_member.idevent = e1.idevent
                                AND event_member.idmember = ?
                                AND event_member.isadmin = true
                                GROUP BY(e1.idevent)
                                ORDER BY attendants DESC LIMIT 9', [$minPrice, $maxPrice, $selected, $user]);
                    }
                }
            }
        }
        public static function searchEventType4($searchField, $selectedRange, $selectedOrder){
		    if($searchField == "")
		    {
                if($selectedOrder == "chrono")
                {
                    if($selectedRange == "all")
                    {
                        return Event::where(
                            'startday','>=', now()->toDateString()
                        )
                            ->orderBy('startday', 'ASC')
                            ->limit(9)
                            ->get();
		            }
                    else
                    {
                        $user = Auth::id();

                        return DB::select('SELECT *
                                FROM event_member INNER JOIN event ON event_member.idevent = event.idevent
                                WHERE event_member.idevent = event.idevent
                                AND event_member.idmember = ?
                                AND event_member.isadmin = true
                                AND event.startday >= \''. now()->toDateString() .'\'
                                ORDER BY event.startday ASC LIMIT 9', [$user]);
		            }
		        }
                else
                {
                    if($selectedRange == "all")
                    {
                        return DB::select('SELECT count(event_member.idmember) as attendants, event.*
                                FROM event_member INNER JOIN event ON event_member.idevent = event.idevent
                                GROUP BY(event.idevent)
                                ORDER BY attendants DESC LIMIT 9');
                    }
                    else
                    {
                        $user = Auth::id();

                        return DB::select('SELECT count(event_member.idmember) as attendants, event.*
                                FROM event_member INNER JOIN event ON event_member.idevent = event.idevent
                                WHERE event.idevent = event_member.idevent
                                AND event_member.idmember = ?
                                AND event_member.isadmin = true
                                GROUP BY(event.idevent)
                                ORDER BY attendants DESC LIMIT 9', [$user]);
                    }
		        }
		    }
            else
            {
                $selected = "%" . $searchField . "%";

                if($selectedOrder == "chrono")
                {
                    if($selectedRange == "all")
                    {
                        return Event::where(
                            [
                                ['name','ILIKE', $selected],
                                ['startday','>=', now()->toDateString()],
                            ]
                        )
                            ->orderBy('startday', 'ASC')
                            ->limit(9)
                            ->get();
                    }
                    else
                    {
                        $user = Auth::id();

                        return DB::select('SELECT event.*
                                FROM event_member INNER JOIN event ON event_member.idevent = event.idevent
                                WHERE fts_vector @@ to_tsquery(\'portuguese\', ?)
                                AND event_member.idevent = event.idevent
                                AND event_member.idmember = ?
                                AND event_member.isadmin = true
                                AND event.startday >= \''. now()->toDateString() .'\'
                                GROUP BY(event.idevent)
                                ORDER BY event.startday DESC LIMIT 9', [$selected, $user]);
                    }
                }
                else
                {
                    if($selectedRange == "all")
                    {
                        return DB::select('SELECT count(event_member.idmember) as attendants, event.*
                                FROM event_member INNER JOIN event ON event_member.idevent = event.idevent
                                WHERE fts_vector @@ to_tsquery(\'portuguese\', ?)
                                GROUP BY(event.idevent)
                                ORDER BY attendants DESC LIMIT 9', [$selected]);
                    }
                    else
                    {
                        $user = Auth::id();

                        return DB::select('SELECT count(event_member.idmember) as attendants, event.*
                                FROM event_member INNER JOIN event ON event_member.idevent = event.idevent
                                WHERE fts_vector @@ to_tsquery(\'portuguese\', ?)
                                AND event.idevent = event_member.idevent
                                AND event_member.idmember = ?
                                AND event_member.isadmin = true
                                GROUP BY(event.idevent)
                                ORDER BY attendants DESC LIMIT 9', [$selected, $user]);
                    }
                }
            }

        }

        public static function nearbyMemberEvents(){

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

		public static function upcomingMemberEvents(){
				return Event::where(
								'startday','>=', now()->toDateString()
						)
						->orderBy('startday', 'ASC')
						->limit(5)
						->get();
		}


		public static function topEvents($limit){ //Mostrar top events, eventos com mais membros que vão
			return Event::where('ispublic', '=', true)->with('attendants')->get()->sortBy(function($event)
			{
				return $event->attendants->count();
			}, null, true)->take($limit); //Using null to skip arguments at function call


		}

        public static function memberTopEvents($limit, $offset){ //Mostrar top events, eventos com mais membros que vão
            return DB::select('SELECT count(event_member.idmember) as attendants, event.*
							FROM event_member INNER JOIN event ON event_member.idevent = event.idevent
                            WHERE event.ispublic = true
							GROUP BY(event.idevent)
							ORDER BY attendants DESC LIMIT ? OFFSET ?', [$limit, $offset]);
		}


		public static function memberManageEvents(){

			$user = Auth::id();

			return DB::select('SELECT event.idevent, event.name, description, imagePath, startday, endday
				FROM event, event_member, member
				WHERE event.idevent = event_member.idevent AND event_member.idmember = ? AND event_member.isadmin = true
				GROUP BY(event.idevent)', [$user]);
		}

		public static function manageEvents(){
			return view('pages.events.manageEvents');

        }

        public static function searchEventByNameAndDesc($searchInput){
		    //DEBUG >>> App\Event::whereRaw('fts_vector @@ to_tsquery(\'initialize\')')->orderBy('startday', 'ASC')->limit(9)->get();
					return Event::whereRaw('fts_vector @@ to_tsquery(\'portuguese\', ?)', [$searchInput])->orderBy('startday', 'ASC')->limit(9)->get();
				}

        public static function getTicketInfo($eventId){
            return TicketType::where('event', '=', $eventId)->get();
        }

        public static function buyTicket(Request $request){

            //$_GET['id'], $_GET['quantity'], $_GET['taxNumber'], $_GET['invoiceName'], $_GET['invoiceAddress'])


            $user = Auth::id();
            //$reqObj = json_decode($request->)

		    $ticketType = TicketType::find($request->ticketTypeId)->get();
		    $availableTickets = $ticketType[0]->availablequantity;
            $totalAmount = $ticketType[0]->price * $request->nrOfTickets;

		    if($availableTickets < $request->nrOfTickets)
                return false;
		    else{
                $invoiceID = DB::table('invoice')->insertGetId([
                    'taxpayernumber' => $request->taxNumber,
                    'name' => $request->invoiceName,
                    'address' => $request->invoiceAddress,
                    'quantity' => $request->nrOfTickets,
                    'amount' => $totalAmount,
                    'date' => now()->toDateString(),
                    'idmember' => $user
                ], 'idinvoice');

                for($i=0; $i < $request->nrOfTickets; $i++)
		            DB::Insert('INSERT INTO ticket (idtickettype, idinvoice) VALUES('.$request->ticketTypeId.','.$invoiceID.')');
		        //this doesn't work dunno why
                TicketType::where('idtickettype', '=', $request->ticketTypeId)->update(['availablequantity' => $availableTickets-$request->nrOfTickets]);
                return response("true",200);
		    }

            return response("false",200);
        }

        public static function inviteToEvent(Request $request){
            $user = Auth::id();

		    $notificationAlreadySent = DB::table('notification')
                ->where([
                    ['type', '=', 'event'],
                    ['recipient', '=', $user],
                    ['buddy', '=', $request->friendId],
                    ['event', '=', $request->eventId]])
                ->get();

		    $frienAlreadyAtEvent =
                DB::table('event')
                    ->join('event_member', function ($join) use ($user, $request) {
                        $join
                            ->on('event_member.idevent', '=', 'event.idevent')
                            ->where([['event_member.idevent', '=', $request->eventId], ['event_member.idmember', '=', $request->friendId]]);
                    })->get();


		    if(sizeof($notificationAlreadySent) > 0 || sizeof($frienAlreadyAtEvent))
                return response("false",200);


            DB::table('notification')->
            insert([
                'timestamp' => now()->toDateString(),
                'type' => 'event','recipient' => $user,
                'buddy' => $request->friendId,
                'event' => $request->eventId
            ]);

            return response("true",200);
        }

        public static function addMeToEvent(Request $request){

		    //dd($request->eventId);

            $user = Auth::id();

            $eventGuy = DB::table('event_member')->where(
                [
                    ['idevent', '=', $request->eventId],
                    ['idmember', '=', $user],
                ])->get();

            if(sizeof($eventGuy) > 0)
                return response("false",200);


            DB::table('event_member')->insert(
                [
                    'idevent' => $request->eventId,
                    'idmember' => $user,
                    'isadmin' => 'false'
                ]
            );

            return response("true",200);
        }
	}
