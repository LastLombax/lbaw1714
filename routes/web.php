<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    if(\Illuminate\Support\Facades\Auth::guest())
        return view('pages/visitorHomePage');
    else
        return view('pages/homePage');
});

//Static Pages
Route::get('about', function () {
        return view('pages.static.about');
});

Route::get('contacts', function () {
    return view('pages.static.contactUs');
});

Route::get('faq', function () {
    return view('pages.static.faq');
});

// Events
Route::get('events/create', 'EventController@createEventForm')->name('createEvent');
Route::get('events', 'EventController@index');
Route::get('events/{event}', 'EventController@showEvent')->name('event');


//Route::post('events/{id}', 'EventController@index')->name('event');

// API
Route::put('api/cards', 'CardController@create');
Route::delete('api/cards/{card_id}', 'CardController@delete');
Route::put('api/cards/{card_id}/', 'ItemController@create');
Route::post('api/item/{id}', 'ItemController@update');
Route::delete('api/item/{id}', 'ItemController@delete');

// Authentication
Route::get('login', 'Auth\LoginController@showLoginForm')->name('login');
Route::post('login', 'Auth\LoginController@login');
Route::get('logout', 'Auth\LoginController@logout')->name('logout');
Route::get('register', 'Auth\RegisterController@showRegistrationForm')->name('register');
Route::post('register', 'Auth\RegisterController@register');
