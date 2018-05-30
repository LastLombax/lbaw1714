<?php

    namespace App\Http\Controllers;
    use Auth;
    use App\Community;
    use App\Http\Controllers\Controller;
    use Illuminate\Support\Facades\DB;
    use Illuminate\Http\Request;
    use Illuminate\Support\Facades\Validator;
    use Illuminate\Support\Facades\Gate;


    class CommunityController extends Controller
    {
        public function index(){
            $communities = Community::all();
            return view('pages.communities.showCommunities')->with('communities', $communities);
        }

        public function createForm(){

            return view('pages.communities.createCommunity');

        }

        public function create(Request $request){


            $this->validator($request->all())->validate();
            $community = new Community();

            $community->name = $request->name;
            $community->description = $request->description;
            $community->creationdate = date('Y-m-d');            
            $community->ispublic = $request->visibility;
            
            $community->save();

            if($request->hasFile('communityImage')) {
                $imgType = $request->file('communityImage')->getMimeType();
                $imgType = '.' . substr($imgType, strpos($imgType, '/') + 1);

                $community->imagepath = 'img/community/' . $community->idcommunity . $imgType;

                $community->save();

                $request->file('communityImage')->storeAs('public/img/community', $community->idcommunity . $imgType);
            }

            DB::table('community_member')->insert(
                [   'idcommunity' => $community->idcommunity,
                    'idmember' => Auth::user()->idmember,
                    'isadmin' => true,
                ]
            );

            return redirect()->route('community', $community->idcommunity);


        }

        public function show(Community $community){

            return view('pages.communities.community')->with('community', $community);
        }

        public function editForm(Community $community){
            
            return view('pages.communities.editCommunity')->with('community', $community);
        }

        public function edit(Request $request, Community $community){

            $this->validator($request->all())->validate();

            $community->name = $request->name;
            $community->description = $request->description;  
            $community->ispublic = $request->visibility;
            
            $community->save();

            if($request->hasFile('communityImage')) {
                $imgType = $request->file('communityImage')->getMimeType();
                $imgType = '.' . substr($imgType, strpos($imgType, '/') + 1);

                $community->imagepath = 'img/community/' . $community->idcommunity . $imgType;

                $community->save();

                $request->file('communityImage')->storeAs('public/img/community', $community->idcommunity . $imgType);
            }


            return redirect()->route('community', $community->idcommunity);
        }


        public function delete(Community $community){

			if (Gate::allows('community-admin', $community)) {

				//Event::find($event->idevent)->delete();
				try {
					$community->delete();
				} catch (\Exception $e) {
					echo "Error in deleting Community";
				}

				return redirect()->route('homepage');
			}

			else
                return view('pages.communities.community')->with('community', $community);

		}

        public static function topCommunities($limit, $offset){ 
            return DB::select('SELECT count(community_member.idmember) as attendants, community.*
                            FROM community_member INNER JOIN community ON community_member.idcommunity = community.idcommunity
                            AND community.ispublic = true
                            GROUP BY(community.idcommunity)
                            ORDER BY attendants DESC LIMIT ? OFFSET ?', [$limit, $offset]);
        }


        protected function validator(array $data) {

            $validate = Validator::make($data, [
                'name' => 'required|string|max:64',
                'description' => 'required|string|max:516',
                'ispublic'=> 'boolean',
            ]);

            return $validate;

        }

        public static function basicSearch(Request $request){
            if (!isset($request->search))
                $communities = Community::where('ispublic', '=','true');            
            else
                 $communities = Community::whereRaw('fts_vector @@ to_tsquery(?) AND ispublic = true', $request->search);
            
            $communities = $communities->orderBy('name', 'ASC')->get();

            return view('pages.communities.viewCommunitiesBasic')->with('communities', $communities);

        }


        public static function manageCommunities(){
            return view('pages.communities.manageCommunities');

        }

        public static function memberManageCommunities(){

            $user = Auth::id();

            return DB::select('SELECT community.idcommunity, community.name, description, imagePath
                FROM community, community_member, member
                WHERE community.idcommunity = community_member.idcommunity AND community_member.idmember = ? AND community_member.isadmin = true
                GROUP BY(community.idcommunity)', [$user]);
        }

        public static function communityFeed($community)
        {
            return DB::select('SELECT timestamp, community, recipient, comment, comment, event
                               FROM "notification"
                               WHERE "notification".community = ?
                               ORDER BY "notification".timestamp', [$community]);

            //    LIMIT $selectedLimit OFFSET $selectedOffset
        }

        public static function communityUpcoming($community)
        {
            $todayDate = date('Y-m-d');
            return DB::select('
                            SELECT idevent, "event".name, "event".description, "event".imagePath, startday, starttime, endtime
                            FROM "event", "community"
                            WHERE "community".idcommunity = ?
                            AND "event".startday >= ?                  
                            Order BY "event".startday DESC', [$community, $todayDate]);

            //    LIMIT $selectedLimit OFFSET $selectedOffset
        }
        
        public static function communityHistory($community)
        {
            $todayDate = date('Y-m-d');
            return DB::select('
                            SELECT idevent, "event".name, "event".description, "event".imagePath, startday, starttime, endtime
                            FROM "event", "community"
                            WHERE "community".idcommunity = ?
                             AND "event".startday <= ?                  
                            Order BY "event".startday DESC', [$community, $todayDate]);

            //    LIMIT $selectedLimit OFFSET $selectedOffset
        }

        public static function inviteToCommunity(Request $request){
            $user = Auth::id();

            $notificationAlreadySent = DB::table('notification')
                ->where([
                    ['type', '=', 'community'],
                    ['recipient', '=', $request->friendId],
                    ['community', '=', $request->communityId]])
                ->get();

            $frienAlreadyAtEvent =
                DB::table('community')
                    ->join('community_member', function ($join) use ($user, $request) {
                        $join
                            ->on('community_member.idcommunity', '=', 'community.idcommunity')
                            ->where([['community_member.idcommunity', '=', $request->communityId], ['community_member.idmember', '=', $request->friendId]]);
                    })->get();


            if(sizeof($notificationAlreadySent) > 0 || sizeof($frienAlreadyAtEvent))
                return response("false",200);


            DB::table('notification')->
            insert([
                'timestamp' => now()->toDateString(),
                'type' => 'community',
                'recipient' => $request->friendId,
                'community' => $request->communityId
            ]);

            /*CREATE TABLE community_member (
                idcommunity integer NOT NULL,
                idmember integer NOT NULL,
                isadmin boolean DEFAULT false NOT NULL*/


            DB::table('community_member')->insert(
                [
                    'idcommunity' => $request->communityId,
                    'idmember' => $request->friendId,
                    'isadmin' => 'false'
                ]
            );

            return response("true",200);
        }


    }
