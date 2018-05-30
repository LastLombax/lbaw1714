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

    public function friends(){
        $member = Auth::user();
        return view('pages.members.friends')->with('member', $member);
    }

    public function searchMembersPage(){
        $member = Auth::user();
        return view('pages.members.searchMembers')->with('member', $member);
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

        $now = date('Y-m-d');
        $validate = Validator::make($data, [
            'name' => 'required|string|min:3|max:50',            
            'country' => 'required|string|exists:country,name',
            'email'=> 'required|email|max:50',
            'birthdate'=> 'date_format:"Y-m-d"|before:' . $now,
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

    public static function getFriendAcceptance($idFriend){
        $user = Auth::id();

        return DB::table('friend')->Where([['idf2', '=', $user],['idf1', '=', $idFriend]])->orWhere([['idf1', '=', $user],['idf2', '=', $idFriend]])->get();
    }


    public static function profileUpcoming($member)
    {
        $todayDate = date('Y-m-d');
        $todayHour = date('H:i:s');
        return DB::select('
                        SELECT "event".idevent, name, description, imagePath, startday, starttime, endtime
                        FROM "event", "event_member"
                        WHERE "event".idevent = "event_member".idevent AND "event_member".idmember = ? 
                         AND "event".startday > ?                  
                        Order BY "event".startday DESC', [$member, $todayDate]);

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
                        ON "event".idevent= "event_member".idevent AND "event_member".idmember = ?
                        WHERE "event".startday <= ?
                        Order BY "event".startday DESC', [$member, $todayDate]);

        //    LIMIT $selectedLimit OFFSET $selectedOffset
    }

    public static function searchMemberByName($selectedName){
            $selected = "%" . $selectedName . "%";

            return Member::where('name','ILIKE', $selected)
                         ->where('username', 'ILIKE', $selected)
                         ->orderBy('startday', 'ASC')->limit(9)->get();
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
                                AND m1.idmember = ?', [$user]);
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
                                AND m1.idmember = ?
                                AND i1.idinvoice = ?', [$user, $id]);
    }

    public static function sendFriendNotification(Request $request)
    {
        $user = Auth::id();

        try {
            DB::Insert('INSERT INTO friend VALUES (?, ?, false)', [$user, $request->idfriend]);
        }
        catch (QueryException $e) {
            return response("false",200);
        }

        DB::Insert('INSERT INTO notification (timestamp, type, community, recipient, comment, event, buddy) VALUES (\''.now()->toDateString().'\', \'buddy\', null, ?, null, null, ?)', [$request->idfriend, $user]);

        return response("true",200);
    }

    public static function getMembersForAdmin(){
        return DB::select('SELECT idmember, name, username
                           FROM member
                            ');
    }

    public static function acceptFriend(Request $request)
    {
        $user = Auth::id();

        DB::table('friend')->where([['idf2', '=', $user],['idf1', '=', $request->idFriend]])->orwhere([['idf1', '=', $user],['idf2', '=', $request->idFriend]])->update(['accepted' => true]);

        return response("true",200);

    }

    public static function blockFriend(Request $request)
    {
        try {
            Notification::find($request->idNotification)->delete();
        }
        catch (QueryException $e) {
            return response("false",200);
        }

        return response("true",200);

    }


    public static function searchFriends(Request $request)
    {
        $user = Auth::id();

        //INSERT INTO event_member(idevent, idmember, isadmin) VALUES (1,101,true);

        $friends = DB::table('friend')
            ->join('member', function ($join) use ($user, $request) {
                $join
                ->on('friend.idf1', '=', 'member.idmember')
                    ->where([['member.idmember', '<>', $user], ['member.username', 'ILIKE', '%'.$request->friendUsername.'%']])
                ->orOn('friend.idf2', '=', 'member.idmember')
                    ->where([['member.idmember', '<>', $user], ['member.username', 'ILIKE', '%'.$request->friendUsername.'%']]);
            })
            // esta linha servia para evitar que utilizadores do mesmo evento aparecessem na pesquisa, mas nao consigo por a funcionar
            /*->join('event_member', function ($join) use ($user, $request) {
                $join
                    ->on('member.idmember', '=', 'event_member.idmember')
                        ->where([['event_member.idevent', '<>', $request->eventId]]);
            })*/
            ->where([['idf2', '=', $user], ['accepted', '=', true]])
            ->orWhere([['idf1', '=', $user], ['accepted', '=', true]])
            ->limit(5)
            ->get();

        return response(json_encode($friends),200);

    }

    public static function getAllFriends()
    {
        $user = Auth::id();

        $friends = DB::table('friend')
            ->join('member', function ($join) use ($user) {
                $join
                    ->on('friend.idf1', '=', 'member.idmember')
                    ->where([['member.idmember', '<>', $user]])
                    ->orOn('friend.idf2', '=', 'member.idmember')
                    ->where([['member.idmember', '<>', $user]]);
            })
            ->where([['idf2', '=', $user], ['accepted', '=', true]])
            ->orWhere([['idf1', '=', $user], ['accepted', '=', true]])
            ->limit(5)
            ->select('member.*')
            ->get();

        return $friends;

    }

    public static function searchMembers($word){
        $user = Auth::id();

        return Member::where([['username', 'ILIKE', '%'.$word.'%'], ['idmember', '<>', $user]])
            ->limit(9)
            ->get();
    }

    public static function searchMyFriends($word){
        $user = Auth::id();

        $friends = DB::table('friend')
            ->join('member', function ($join) use ($user, $word) {
                $join
                    ->on('friend.idf1', '=', 'member.idmember')
                    ->where([['member.idmember', '<>', $user], ['member.username', 'ILIKE', '%'.$word.'%']])
                    ->orOn('friend.idf2', '=', 'member.idmember')
                    ->where([['member.idmember', '<>', $user], ['member.username', 'ILIKE', '%'.$word.'%']]);
            })
            ->where([['idf2', '=', $user], ['accepted', '=', true]])
            ->orWhere([['idf1', '=', $user], ['accepted', '=', true]])
            ->limit(12)
            ->select('member.*')
            ->get();

        return $friends;
    }


//INSERT INTO notification (timestamp, type, community, recipient, comment, event, buddy) VALUES ('2017-12-17 12:26:03', 'buddy', null, 102, null, null, 101);

}
