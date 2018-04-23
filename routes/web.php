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

//Homepage
Route::get('/', function () {
    if(Auth::guest())
        return view('pages/visitorHomePage');
    else
        return view('pages/homePage');
})->name('homepage');

//search
Route::get('search', function () {
    return view('internal.search');
})->name('search');

Route::get('slide', function () {
    return view('internal.slideshow');
})->name('slide');

Route::get('time', function () {
    return view('internal.timeline');
})->name('time');


// Member
Route::get('members/edit', 'MemberController@editForm')->name('editForm');
Route::get('members/{username}', 'MemberController@show')->name('profile')->where('username', '\w{3,}');
Route::patch('members/edit', 'MemberController@edit')->name('editForm');
Route::get('/password/reset', 'MemberController@passResetForm')->name('passReset');
Route::patch('/password/reset', 'MemberController@passReset')->name('passReset');

// Events
Route::get('events', 'EventController@index')->name('events');
Route::get('events/{event}', 'EventController@show')->name('event')->where('event', '[0-9]+');
Route::get('events/{event}/edit', 'EventController@editForm')->name('editEvent')->where('event', '[0-9]+');

Route::patch('events/{event}', 'EventController@edit')->name('editEvent');
Route::get('events/create', 'EventController@createForm')->name('createEvent');
Route::post('events/create', 'EventController@create')->name('createEvent');
Route::delete('events/{event}', 'EventController@delete')->name('deleteEvent');
Route::get('events/manageEvents', 'EventController@manageEvents')->name('manageEvents');
Route::post('ajax/events/inviteMember', 'EventController@inviteMember')->name('inviteEvent');



// Communities
Route::get('communities', 'CommunityController@index')->name('communities');
Route::get('communities/{community}', 'CommunityController@show')->name('community')->where('community', '[0-9]+');
Route::get('communities/{community}/edit', 'CommunityController@editForm')->name('editCommunity')->where('community', '[0-9]+');
Route::patch('communities/{community}/edit', 'CommunityController@edit')->name('editCommunity');
Route::get('communities/create', 'CommunityController@createForm')->name('createCommunity');
Route::post('communities/create', 'CommunityController@create')->name('createCommunity');
Route::delete('communities/{community}', 'CommunityController@delete')->name('deleteCommunity');
Route::get('communities/manageCommunities', 'CommunityController@manageCommunities')->name('manageCommunities');


// API

// Authentication
Route::get('login', 'Auth\LoginController@showLoginForm')->name('login');
Route::post('login', 'Auth\LoginController@login');
Route::get('logout', 'Auth\LoginController@logout')->name('logout');
Route::get('register', 'Auth\RegisterController@showRegistrationForm')->name('register');
Route::post('register', 'Auth\RegisterController@register');


//Static Pages
Route::get('about', function () {
    return view('pages.static.about');
})->name('about');

Route::get('contact', function () {
    return view('pages.static.contactUs');
})->name('contact');

Route::get('faq', function () {
    return view('pages.static.faq');
})->name('faq');

Route::get('404', function () {
    return view('pages.static.404');
})->name('404');