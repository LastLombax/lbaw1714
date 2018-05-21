<?php
 
use App\Comment;
use App\Community;
use App\Event;
use App\Member;

$query = \App\Http\Controllers\MemberController::profileFeed($member->idmember);

foreach ($query as $notification){

	switch($notification->type){
		case 'buddy':
			$buddyName = Member::find($notification->buddy)->username;
   			$membersLink = route('members');
   			$link = $membersLink . '/' . $buddyName;
   			 echo '
				  <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
			        <h5 class="mb-1"> 
			        	<a href=" '.$link.'">'.$buddyName . '</a> wants to be your buddy!</h5>
			        <small>
			        	<button onclick="acceptRequest($notification->buddy)"> Accept </button>
			        	<button onclick="ignoreRequest($notification->buddy)"> Ignore </button>
			        </small>
			        <small>' . $notification->getTime() .' day(s) ago</small>
			    </a>
			';
			break;
		case 'comment':
			$eventName = Event::find($notification->event)->name;
   			$eventsLink = route('events');
   			$link = $eventsLink . '/' . $notification->event;
   			$commentText = Comment::find($notification->comment)->text;
   			echo '
			   <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
		        <h5 class="mb-1"> There\'s a new comment in <a href=" '.$link.'">'.$eventName . '</a> </h5>
		        <small>
		        	'. $commentText .'
			    </small>
		        <small>' . $notification->getTime() .' day(s) ago</small>
		    </a>
			';
			break;
		case 'event':
			$eventName = Event::find($notification->event)->name;
   			$eventsLink = route('events');
   			$link = $eventsLink . '/' . $notification->event;
   			echo '
			   <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
		        <h5 class="mb-1"> You have been invited to the Event<a href=" '.$link.'">'.$eventName . '</a> </h5>
		       <small>' . $notification->getTime() .' day(s) ago</small>
		    </a>
			';
			break;
		case 'community':
			$communityName = Community::find($notification->community)->name;
   			$communitiesLink = route('communities');
   			$link = $communitiesLink . '/' . $notification->community;
   			echo '
			   <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
		        <h5 class="mb-1"> You have been invited to the Community <a href=" '.$link.'">'.$communityName . '</a> </h5>
		       <small>' . $notification->getTime() .' day(s) ago</small>
		    </a>
			';
			break;

	}
}

?>