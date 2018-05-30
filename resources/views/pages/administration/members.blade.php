<?php
	
	$query = \App\Http\Controllers\MemberController::getMembersForAdmin();

	if (count($query) == 0) {
		echo '<div style="height:6em; text-align: center;" class="card-body">';
		echo 'No members to show';
		echo '</div>';
	} 
	foreach($query as $member){

		echo '
			<div  class="list-group-item list-group-item-action flex-column align-items-start ">
				<div class="d-flex w-100 justify-content-between">
					<h5 class="mb-1">'. $member->name . ' </h5>
					<button class="btn btn-danger">
					<i class="fas fa-ban"></i>
						Ban
					</button>
				</div>';
		echo' <a href=" members/' . $member->username.'">
			<small class="mb-1">View Profile</small>
				</a>
			</div>
		';
	}
?>

