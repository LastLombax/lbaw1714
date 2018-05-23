<?php

use App\Http\Controllers\EventController;

$query;

if (isset($_GET['id'])) {
    $query = EventController::buyTicket($_GET['id']);
}

// JSON encode
echo json_encode($query);
?>