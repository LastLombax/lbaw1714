<?php

    namespace App\Http\Controllers;
    use Auth;
    use App\Community;
    use App\Http\Controllers\Controller;
    use Illuminate\Foundation\Request;
    use Illuminate\Support\Facades\DB;

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

            dd($request);
            return view('pages.community.createCommunity');

        }

        public function show(Community $community){

            return view('pages.communities.community')->with('community', $community);
        }

        public function editForm(Community $community){
            
            return view('pages.communities.editCommunity')->with('community', $community);
        }

        public function edit(Event $event){

            return view('pages.events.event')->with('community', $community);
        }

        public function delete(Community $community){

            return view('pages.communities.community')->with('community', $community);
        }

        public static function topCommunities($limit, $offset){ 
            return DB::select('SELECT count(community_member.idmember) as attendants, community.*
                            FROM community_member INNER JOIN community ON community_member.idcommunity = community.idcommunity
                            GROUP BY(community.idcommunity)
                            ORDER BY attendants DESC LIMIT ' . $limit . ' OFFSET ' . $offset);
        }

        public static function manageCommunities(){
            return view('pages.communities.manageCommunities');

        }

        public static function memberManageCommunities(){

            $user = Auth::id();

            return DB::select('SELECT community.idcommunity, community.name, description, imagePath
                FROM community, community_member, member
                WHERE community.idcommunity = community_member.idcommunity AND community_member.idmember = ' . $user . ' AND community_member.isadmin = true
                GROUP BY(community.idcommunity)');
        }

        public static function communityFeed($community)
        {
            return DB::select('SELECT timestamp, community, recipient, comment, comment, event
                               FROM "notification"
                               WHERE "notification".community = '.$community.'
                               ORDER BY "notification".timestamp');

            //    LIMIT $selectedLimit OFFSET $selectedOffset
        }

        public static function communityUpcoming($community)
        {
            $todayDate = date('Y-m-d');
            $todayHour = date('H:i:s');
            return DB::select('
                            SELECT idevent, "event".name, "event".description, "event".imagePath, startday, starttime, endtime
                            FROM "event", "community"
                            WHERE "community".idcommunity = '. $community .'
                             AND "event".startday >= \'' . $todayDate . ' \'                  
                            Order BY "event".startday DESC');

            //    LIMIT $selectedLimit OFFSET $selectedOffset
        }
        
        public static function communityHistory($community)
        {
            $todayDate = date('Y-m-d');
            $todayHour = date('H:i:s');
            return DB::select('
                            SELECT idevent, "event".name, "event".description, "event".imagePath, startday, starttime, endtime
                            FROM "event", "community"
                            WHERE "community".idcommunity = '. $community .'
                             AND "event".startday <= \'' . $todayDate . ' \'                  
                            Order BY "event".startday DESC');

            //    LIMIT $selectedLimit OFFSET $selectedOffset
        }


    }
