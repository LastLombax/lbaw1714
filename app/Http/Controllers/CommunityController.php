<?php

    namespace App\Http\Controllers;

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


    }
