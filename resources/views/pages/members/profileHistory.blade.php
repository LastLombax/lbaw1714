<?php
 

$query = \App\Http\Controllers\MemberController::profileHistory($member->idmember);


$eventsLink = route('events');
foreach ($query as $event){
  echo '   <div class="list-group-item list-group-item-action flex-column align-items-start">
                <div class="d-flex w-100 justify-content-between">
                    <a href="">
                        <h5 class="mb-1">LBAW A1</h5>
                    </a>
                    <small>1 week ago</small>
                </div>
                <p class="mb-1">Event to deliver the 1st Artifact of LBAW</p>
            <a href="">
                <small> Click here to see your ticket.</small>
            </a>
        </div>
';
}


?>