<?php

$query = \App\Http\Controllers\EventController::memberTopEvents(4,0);

$first = $query[0];

echo '<div class="card-body">';
echo '<h5 class="card-title" style="font-size: 1.2em">' . $first->name . '</h5>';
echo '<h6 class="card-subtitle text-muted">' . $first->startday . '</h6>';
echo '</div>';
echo '<img style="width: 100%; height: 200px; object-fit: cover;" src="' . $first->imagepath . '" alt="Card image">';
echo '<div class="card-body">';
echo '<p class="card-text">' . $first->description . '</p>';
echo'</div>';

echo '<ul class="list-group list-group-flush">';

$eventsLink = route('events');
$i = 0;
foreach ($query as $event){
    $i++;
    if($i != 1)
    {
        echo '<li class="list-group-item" style="font-size: 1.2em">';
        $link = $eventsLink . '/' . $event->idevent;
        echo "<a href=\"$link\"> . $event->name</a>";
        echo '</li>';
    }
}

echo '</ul>';


echo '<div class="card-footer text-muted">';
echo "<a href=\"$eventsLink\" class=\"card-link\">More Events</a>";
echo '</div>';
?>