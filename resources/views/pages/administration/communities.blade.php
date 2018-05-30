<?php

	
	$query = \App\Http\Controllers\CommunityController::getCommunitiesForAdmin();

	if (count($query) == 0) {
		echo '<div style="height:6em; text-align: center;" class="card-body">';
		echo 'No communities to show';
		echo '</div>';
	} 
	foreach($query as $community){
        $communitiesLink = route('communities');

        $link = $communitiesLink . '/' .$community->idcommunity;

		echo '
			<div class="list-group-item list-group-item-action flex-column align-items-start ">
				<div class="d-flex w-100 justify-content-between">
					<h5 class="mb-1">'. $community->name . ' </h5>
					<button class="btn btn-danger">
					<i class="fas fa-ban"></i>
						Disable
					</button>
				</div>';
		echo' <a href=" '.$link.'">
			<small class="mb-1">View Community</small>
				</a>
			</div>
		';
	}

?>

