<?php
 

$query = \App\Http\Controllers\MemberController::profileUpcoming($member->idmember);


foreach ($query as $event){
  echo '
	       <div class="list-group-item list-group-item-action flex-column align-items-start">
                <div class="d-flex w-100 justify-content-between">
                    <h5 class="mb-1">Piggybank Party</h5>
                    <small>Tomorrow</small>
                </div>
                <p class="mb-1">A party for all Piggybank lovers!</p>
            <a href="">
                <small> Click here to see your ticket.</small>
            </a>
         </div>
';
}


?>