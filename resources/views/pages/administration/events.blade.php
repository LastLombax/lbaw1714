<?php
	
	$query = \App\Http\Controllers\EventController::getEventsForAdmin();

	if (count($query) == 0) {
		echo '<div style="height:6em; text-align: center;" class="card-body">';
		echo 'No events to show';
		echo '</div>';
	} 
	foreach($query as $event){
        $eventsLink = route('events');

        $link = $eventsLink . '/' .$event->idevent;

		echo '
			<div class="list-group-item list-group-item-action flex-column align-items-start ">
				<div class="d-flex w-100 justify-content-between">
					<h5 class="mb-1">'. $event->name . ' </h5>
					<button class="btn btn-danger">
					<i class="fas fa-ban"></i>
						Disable
					</button>
				</div>
				<p class="mb-1">' . $event->description .' </p>';
		echo' <a href=" '.$link.'">
			<small class="mb-1">View Event</small>
				</a>
			</div>
		';
	}

?>

