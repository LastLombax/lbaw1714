<?php

use App\Http\Controllers\EventController;

$query;

if (isset($_GET['id']) && isset($_GET['quantity'])) {
    $query = EventController::buyTicket($_GET['id'], $_GET['quantity']);
}

// JSON encode
echo json_encode($query);
?>