<?php

if (isset($_GET['searchField'])) {

    $query = \App\Http\Controllers\EventController::nearbyPublicEvents();
    $messages = $query->fetchAll();
}

// JSON encode
echo $messages->with('data', json_encode($data));
?>