<?php

namespace App\Http\Controllers;

use App\Member;
use App\Country;
use App\Notification;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Gate;

class MemberController extends Controller
{


    public function index(){
      /*  $members = Member::all();
        return view('pages.events.viewEvents')->with('events', $events);*/
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Member  $member
     * @return \Illuminate\Http\Response
     */
    public function show($username)
    {
        $member = Member::where("username", '=', $username)->first();
        return view('pages.members.profile')->with('member', $member);
    }

     public function authProfile()
    {
        $member = Auth::user();
        return view('pages.members.profile')->with('member', $member);
    }


    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Member  $member
     * @return \Illuminate\Http\Response
     */
    public function editForm(){
        $member = Auth::user();
        return view('pages.members.editProfile')->with('member', $member);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Member  $member
     * @return \Illuminate\Http\Response
     */
    public function edit(Request $request)
    {
				
       $member = Auth::user();
  		if (Gate::allows('edit-profile', $member)) {

          $this->editValidator($request->all())->validate();
          
          $member->name = $request->name;
          $member->birthdate = $request->birthdate;

    			if($request->hasFile('eventImage')) {
      			$imgType = $request->file('eventImage')->getMimeType();
      			$imgType = '.' . substr($imgType, strpos($imgType, '/') + 1);

      			$member->profilepicture = 'img/member/' . $member->username . $imgType;

      			$request->file('eventImage')->storeAs('public/img/member', $member->username . $imgType);
    			}

          $member->address = $request->address;
          $member->idcountry = Country::where('name', '=', $request->country)->first()->idcountry;
          $member->about = $request->about;

          $member->email = $request->email;
          if(isset($request->password)){
              if($request->password == $request->password_confirmation)
                  $member->password = Hash::make($request->password);
              else
                  return "Passwords need to be the same";
          }
               
          $member->save();
         }

      return redirect()->route('authProfile');
    }

    protected function createValidator(array $data) {

        return $validate = Validator::make($data, [
            'username' => 'required|string|min:3|max:16|unique:member',      
            'name' => 'required|string|min:3|max:50',
						'country' => 'required|string|exists:country',
            'email'=> 'required|email|max:50|unique:member',
            'password' => 'required|string|max:50|confirmed',            
        ]);
    }


    protected function editValidator(array $data) {

        $validate = Validator::make($data, [
            'name' => 'required|string|min:3|max:50',            
            'country' => 'required|string|exists:country,name',
            'email'=> 'required|email|max:50',
            'birthdate'=> 'nullable|date_format:"Y-m-d"',
            'address'=> 'nullable|string|max:50',
            'about' => 'nullable|string|max:256',
            'password' => 'nullable|string|max:50|confirmed',
            
        ]);
        return $validate;
    }
    

    public static function profileFeed($member)
    {

       return Notification::where('recipient', '=', $member)->orderBy('timestamp','DESC')->get();

        //    LIMIT $selectedLimit OFFSET $selectedOffset
    }

    public static function profileUpcoming($member)
    {
        $todayDate = date('Y-m-d');
        $todayHour = date('H:i:s');
        return DB::select('
                        SELECT "event".idevent, name, description, imagePath, startday, starttime, endtime
                        FROM "event", "event_member"
                        WHERE "event".idevent = "event_member".idevent AND "event_member".idmember ='.$member.'  
                         AND "event".startday >= \'' . $todayDate . ' \'                  
                        Order BY "event".startday DESC');

        //    LIMIT $selectedLimit OFFSET $selectedOffset
    }
    
    public static function profileHistory($member)
    {
        $todayDate =date('Y-m-d');
        $todayHour = date('H:i:s');
        
        return DB::select('
                        SELECT "event".idevent, name, description, imagePath, startday, endday, starttime, endtime
                        FROM "event"
                        INNER JOIN event_member
                        ON "event".idevent= "event_member".idevent AND "event_member".idmember = '.$member .'
                        WHERE "event".startday <= \'' . $todayDate . ' \'
                        Order BY "event".startday DESC');

        //    LIMIT $selectedLimit OFFSET $selectedOffset
    }

    public static function searchMemberByName($selectedName){
            $selected = "%" . $selectedName . "%";

            return Member::where('name','LIKE', $selected)
                         ->where('username', 'LIKE', $selected)
                         ->orderBy('startday', 'ASC')->limit(9)->get();
    }

    /*public function sendBuddyRequest(){
        $now = now();
        dd($now);
        return DB::insert('
                        INSERT INTO "notification"
                        VALUES '. $now . 'buddy, null,' .$Auth::id() .', null, null,' . $member);
    }*/

    public function removeBuddy($member){
        $now = now();
        return DB::insert('
                        INSERT INTO "notification"
                        VALUES '. $now . 'invite, null,' .$member .', null, null');
    }

    public static function invoices(){
        $user = Auth::id();

        return DB::select('SELECT DISTINCT e1.name as name,
                            e1.imagepath as image,
                             tt1.description as description,
                              i1.idinvoice as id,
                               i1.quantity as quantity,
                                i1.amount as amount
                                FROM event e1, member m1, tickettype tt1, ticket t1, invoice i1
                                WHERE
                                i1.idinvoice = t1.idinvoice
                                AND tt1.idtickettype = t1.idtickettype
                                AND tt1.event = e1.idevent
                                AND i1.idmember = m1.idmember
                                AND m1.idmember = ' . $user);
    }

    public static function getinvoices($id){
        $user = Auth::id();

        return DB::select('SELECT DISTINCT e1.name as name,
                            e1.imagepath as image,
                             tt1.description as description,
                              i1.idinvoice as id,
                               i1.quantity as quantity,
                                i1.amount as amount
                                FROM event e1, member m1, tickettype tt1, ticket t1, invoice i1
                                WHERE
                                i1.idinvoice = t1.idinvoice
                                AND tt1.idtickettype = t1.idtickettype
                                AND tt1.event = e1.idevent
                                AND i1.idmember = m1.idmember
                                AND m1.idmember = ' . $user .'
                                AND i1.idinvoice = '.$id);
    }

    public static function sendFriendNotification(Request $request)
    {
        $user = Auth::id();

        try {
            DB::Insert('INSERT INTO friend VALUES ('.$user.', '.$request->idfriend.', false)');
        }
        catch (QueryException $e) {
            return response("false",200);
        }

        DB::Insert('INSERT INTO notification (timestamp, type, community, recipient, comment, event, buddy) VALUES (\''.now()->toDateString().'\', \'buddy\', null, '.$request->idfriend.', null, null, '.$user.')');

        return response("true",200);
    }

//INSERT INTO notification (timestamp, type, community, recipient, comment, event, buddy) VALUES ('2017-12-17 12:26:03', 'buddy', null, 102, null, null, 101);

}
