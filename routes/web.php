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
use App\Invoice;

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

//Advanced Search
Route::get('advancedSearch', function () {
    return view('internal.advancedSearch');
})->name('advancedSearch');

Route::get('slide', function () {
    return view('internal.slideshow');
})->name('slide');

Route::get('time', function () {
    return view('internal.timeline');
})->name('time');




// Member Access
Route::group(['middleware' => 'App\Http\Middleware\MemberMiddleware'], function()
{

    Route::get('profile', 'MemberController@authProfile')->name('authProfile');
    Route::get('profile/edit', 'MemberController@editForm')->name('editForm');
    Route::patch('profile/edit', 'MemberController@edit')->name('editForm');
    Route::get('/password/reset', 'MemberController@passResetForm')->name('passReset');
    Route::patch('/password/reset', 'MemberController@passReset')->name('passReset');

    // Events
    Route::get('events/create', 'EventController@createForm')->name('createEvent');
    Route::post('events/create', 'EventController@create')->name('createEvent');
    Route::get('events/manageEvents', 'EventController@manageEvents')->name('manageEvents');

    //Comments
    Route::delete('ajax/events/comment', 'EventController@inviteMember');


    //Communities
    Route::get('communities/create', 'CommunityController@createForm')->name('createCommunity');
    Route::post('communities/create', 'CommunityController@create')->name('createCommunity');    
    Route::get('communities/manageCommunities', 'CommunityController@manageCommunities')->name('manageCommunities');

    //Members
    Route::post('buddies/add/{member}', 'MemberController@sendBuddyRequest')->name('sendBuddyRequest')->where('member', '[0-9]+}');

    Route::post('buddies/remove/{member}', 'MemberController@removeBuddy')->name('removeBuddy')->where('member', '[0-9]+}');

    //Tickets
    Route::post('buyTicket', 'EventController@buyTicket');

    Route::get('invoice/{id}', function($id){
        $invoice = Invoice::find($id);
        return view('pages.events.invoice')->with('invoice', $invoice);
    })->where('id', '[0-9]+');

});

// Members
//Route::get('members', 'MemberController@index')->name('members');
Route::get('members/{username}', 'MemberController@show')->name('member')->where('username', '\w{3,}');


// Events
Route::get('events', 'EventController@index')->name('events');
Route::get('events/{event}', 'EventController@show')->name('event')->where('event', '[0-9]+');

//Event Admin
Route::get('events/{event}/edit', 'EventController@editForm')->name('editEvent')->where('event', '[0-9]+');
Route::patch('events/{event}', 'EventController@edit')->name('editEvent');
Route::delete('events/{event}', 'EventController@delete')->name('deleteEvent');
Route::post('ajax/events/inviteMember', 'EventController@inviteMember')->name('inviteEvent');



// Communities
Route::get('communities', 'CommunityController@index')->name('communities');
Route::get('communities/{community}', 'CommunityController@show')->name('community')->where('community', '[0-9]+');

//Community Admin
Route::get('communities/{community}/edit', 'CommunityController@editForm')->name('editCommunity')->where('community', '[0-9]+');
Route::patch('communities/{community}/edit', 'CommunityController@edit')->name('editCommunity');
Route::delete('communities/{community}', 'CommunityController@delete')->name('deleteCommunity');


// API

// Authentication
Route::group(['middleware' => 'App\Http\Middleware\GuestMiddleware'], function()
{
    Route::get('login', 'Auth\LoginController@showLoginForm')->name('login');
    Route::post('login', 'Auth\LoginController@login');
    Route::get('register', 'Auth\RegisterController@showRegistrationForm')->name('register');
    Route::post('register', 'Auth\RegisterController@register');


    Route::get('password/reset', 'Auth\ForgotPasswordController@showLinkRequestForm')->name('password.request');
    Route::post('password/email', 'Auth\ForgotPasswordController@sendResetLinkEmail')->name('password.email');

    Route::get('password/reset/{token}', 'Auth\ResetPasswordController@showResetForm')->name('password.reset');
    Route::post('password/reset', 'Auth\ResetPasswordController@reset')->name('password.change');
});



Route::get('logout', 'Auth\LoginController@logout')->name('logout');


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