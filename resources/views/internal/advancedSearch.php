<?php

class Security{

    public function forSecurityReasons($searchField, $selectedRange, $selectedCountry, $minPrice, $maxPrice, $selectedOrder){

    }

}

if(
    isset($_GET['searchField']) && isset($_GET['selectedRange']) && isset($_GET['selectedCountry']) &&
    isset($_GET['minPrice']) && isset($_GET['maxPrice']) && isset($_GET['selectedOrder'])
)
{
    $query = \App\Http\Controllers\EventController::searchEventType1(
        $_GET['searchField'],
        $_GET['selectedRange'],
        $_GET['selectedCountry'],
        $_GET['minPrice'],
        $_GET['maxPrice'],
        $_GET['selectedOrder']
    );

}
else if(
    isset($_GET['searchField']) && isset($_GET['selectedRange']) && isset($_GET['selectedCountry']) &&
    isset($_GET['selectedOrder'])
)
{
    $query = \App\Http\Controllers\EventController::searchEventType2(
        $_GET['searchField'],
        $_GET['selectedRange'],
        $_GET['selectedCountry'],
        $_GET['selectedOrder']
    );

}
else if(
    isset($_GET['searchField']) && isset($_GET['selectedRange']) &&
    isset($_GET['minPrice']) && isset($_GET['maxPrice']) && isset($_GET['selectedOrder'])
)
{
    $query = \App\Http\Controllers\EventController::searchEventType3(
        $_GET['searchField'],
        $_GET['selectedRange'],
        $_GET['minPrice'],
        $_GET['maxPrice'],
        $_GET['selectedOrder']
    );

}
else if(
    isset($_GET['searchField']) && isset($_GET['selectedRange']) && isset($_GET['selectedOrder'])
)
{
    $query = \App\Http\Controllers\EventController::searchEventType4(
        $_GET['searchField'],
        $_GET['selectedRange'],
        $_GET['selectedOrder']
    );

}

// JSON encode
echo json_encode($query);
