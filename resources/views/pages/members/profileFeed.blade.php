<?php
 
$query = \App\Http\Controllers\MemberController::profileFeed($member->idmember);


foreach ($query as $notification){

  if ($notification->event != null)
	  echo '
		  <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
	        <h5 class="mb-1">God created a new Event in Community Feupinhos: Feupinhos na Queima</h5>
	        <small>1 day ago</small>
	    </a>
	';
}


?>