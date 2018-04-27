<?php
 
$query = \App\Http\Controllers\CommunityController::communityFeed($community->idcommunity);


foreach ($query as $feed){

	  echo '         <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
                        <h5 class="mb-1">Y´all need Jesus</h5>
                        <small class="text-muted">Right now</small>
                    </a>
                   
              
	';
}


?>