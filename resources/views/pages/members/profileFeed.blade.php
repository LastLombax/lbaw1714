<?php

use App\Comment;
use App\Community;
use App\Event;
use App\Member;

$query = \App\Http\Controllers\MemberController::profileFeed($member->idmember);

foreach ($query as $notification){

	switch($notification->type){
		case 'buddy':
            $friendAccepted = \App\Http\Controllers\MemberController::getFriendAcceptance($notification->buddy)[0];

            if(!$friendAccepted->accepted){
                $buddyName = Member::find($notification->buddy)->username;

                $link = '/member/' . $buddyName;
                 echo '
                      <div class="list-group-item list-group-item-action flex-column align-items-start" id="buddyRequest'.$notification->buddy.'">
                        <div class="d-flex w-100 justify-content-between">
                        <h5 class="mb-1">
                            <a href=" '.$link.'">'.$buddyName . '</a> wants to be your buddy!
                        </h5>
                        <div>
                            <button class="btn btn-info" onclick="acceptRequest('.$notification->buddy.')"> Accept </button>
                            <button class="btn btn-secondary" onclick="blockRequest('.$notification->idnotification.')"> Block </button>
                        </div>
                        </div>
                        <small>' . $notification->getTime() .' day(s) ago</small>
                    </div>
                ';
		    }
			break;
		case 'comment':
			//dd($notification);
			$eventName = Event::find($notification->event)->name;
   			$eventsLink = route('events');
   			$link = $eventsLink . '/' . $notification->event;
   			$commentText = Comment::find($notification->comment)->text;
   			echo '
			   <div class="list-group-item list-group-item-action flex-column align-items-start">
		        <h5 class="mb-1"> There\'s a new comment in <a href=" '.$link.'">'.$eventName . '</a> </h5>
		        <p class="mb-1">
		        	'. $commentText .'
			    </p>
		        <small>' . $notification->getTime() .' day(s) ago</small>
		    </div>
			';
			break;
		case 'event':
			$eventName = Event::find($notification->event)->name;
   			$eventsLink = route('events');
   			$link = $eventsLink . '/' . $notification->event;
   			echo '
			   <div class="list-group-item list-group-item-action flex-column align-items-start">
		        <h5 class="mb-1"> You have been invited to the Event <a href=" '.$link.'">'.$eventName . '</a> </h5>
		       <small>' . $notification->getTime() .' day(s) ago</small>
		    </div>
			';
			break;
		case 'community':
		    //dd($notification->type);
			$communityName = Community::find($notification->community)->name;
   			$communitiesLink = route('communities');
   			$link = $communitiesLink . '/' . $notification->community;
   			echo '
			   <div class="list-group-item list-group-item-action flex-column align-items-start">
		        <h5 class="mb-1"> You have been invited to the Community <a href=" '.$link.'">'.$communityName . '</a> </h5>
		       <small>' . $notification->getTime() .' day(s) ago</small>
		    </div>
			';
			break;

	}
}

?>