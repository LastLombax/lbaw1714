<?php

    namespace App\Http\Controllers;

    use App\Community;
    use App\Http\Controllers\Controller;
    use Illuminate\Foundation\Request;

    class CommunityController extends Controller
    {
        public function index(){
            $communities = Community::all();
            return view('pages.communities.showCommunities')->with('communities', $communities);
        }

        public function createCommunityForm(){

            return view('pages.communities.createCommunity');

        }

        public function showCommunity(Community $community){

            return view('pages.communities.community')->with('community', $community);
        }

        public function editCommunityForm(Community $community){
            
            return view('pages.communities.editCommunity')->with('community', $community);
        }

        public function editCommunity(Event $event){

            return view('pages.events.event')->with('community', $community);
        }

        public function deleteCommunity(Community $community){

            return view('pages.communities.community')->with('community', $community);
        }

//      public static function topEvents(){ Mostrar top events, eventos com mais membros que vão
//          return Event:: Event::memberTuples())->orderBy('attendants', 'DESC')
//              ->limit(4)
//              ->get();
//      }


    }
