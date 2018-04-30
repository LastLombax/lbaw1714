<?php

	use Illuminate\Support\Facades\Storage;

	$query = \App\Http\Controllers\EventController::memberTopEvents(4,0);

$eventsLink = route('events');
$i = 0;
foreach ($query as $event){
    $i++;
    $link = $eventsLink . '/' . $event->idevent;

    echo '<div style="border: 1px solid #ddd; box-shadow: 1px 1px 30px #ddd;">';
    echo '<div class="card-body" >';
    echo '<h5 class="card-title" style="font-size: 1.2em;"><h2><a href="' . $link . '" style="color: #000">' . $event->name . '</a></h2></h5>';
    echo '<h6 class="card-subtitle text-muted">' . $event->startday . '</h6>';
    echo '</div>';
    echo '<img style="width: 100%; height: 200px; object-fit: cover;" src="' . Storage::url($event->imagepath) . '" alt="Card image">';
    echo '<div class="card-body">';
    echo '<p class="card-text">' . $event->description . '</p>';
    echo'</div>';

    echo '<ul class="list-group list-group-flush">';

    echo '<li class="list-group-item" style="font-size: 1.2em; text-align: right;">';
    echo "<a href=\"$link\"> More</a>";
    echo '</li>';

    echo '</ul>';
    echo '</div>';
    echo '<br>';

}
?>