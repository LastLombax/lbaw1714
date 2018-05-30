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


use App\Http\Controllers\MemberController;
use App\Invoice;

//Homepage
Route::get('/', function () {
    if(Auth::guest())
        return view('pages/visitorHomePage');
    else
        return view('pages/homePage');
})->name('homepage');

//Search
Route::get('search', function () {
    return view('internal.search');
})->name('search');

//Search Friend
Route::get('searchFriend', function () {
    return view('internal.searchFriends');
})->name('searchFriend');

//Advanced Search
Route::get('advancedSearch', function () {
    return view('internal.advancedSearch');
})->name('advancedSearch');

//Slideshow
Route::get('slide', function () {
    return view('internal.slideshow');
})->name('slide');

//Timeline
Route::get('time', function () {
    return view('internal.timeline');
})->name('time');

// Guest Access
Route::group(['middleware' => 'App\Http\Middleware\RedirectIfAuthenticated'], function(){

    Route::get('basicEventSearch','EventController@basicSearch')->name('basicEventsSearch');
    Route::get('basicCommunitySearch','CommunityController@basicSearch')->name('basicCommunitiesSearch');

});

// Member Access
Route::group(['middleware' => 'App\Http\Middleware\MemberMiddleware'], function(){

    Route::get('profile', 'MemberController@authProfile')->name('authProfile');
    Route::get('profile/edit', 'MemberController@editForm')->name('editForm');
    Route::patch('profile/edit', 'MemberController@edit')->name('editForm');
    Route::get('/password/reset', 'MemberController@passResetForm')->name('passReset');
    Route::patch('/password/reset', 'MemberController@passReset')->name('passReset');

    // Events
    Route::get('events/create', 'EventController@createForm')->name('createEvent');
    Route::post('events/create', 'EventController@create')->name('createEvent');
    Route::get('events/manageEvents', 'EventController@manageEvents')->name('manageEvents');
    Route::post('addMeToEvent', 'EventController@addMeToEvent');


    //Comments
    Route::delete('ajax/events/comment', 'CommentController@destroy');
    Route::post('ajax/events/comment', 'CommentController@store');
    Route::patch('ajax/events/comment', 'CommentController@update');


    //Communities
    Route::get('communities/create', 'CommunityController@createForm')->name('createCommunity');
    Route::post('communities/create', 'CommunityController@create')->name('createCommunity');
    Route::get('communities/manageCommunities', 'CommunityController@manageCommunities')->name('manageCommunities');
    Route::get('communities','CommunityController@basicSearch')->name('communities');


    //Friends
    Route::post('sendFriendNotification', 'MemberController@sendFriendNotification');
    Route::post('acceptFriend', 'MemberController@acceptFriend');
    Route::post('blockFriend', 'MemberController@blockFriend');
    Route::post('searchFriends', 'MemberController@searchFriends');
    Route::post('inviteToEvent', 'EventController@inviteToEvent');
    Route::post('inviteToCommunity', 'CommunityController@inviteToCommunity');

    Route::get('friends', 'MemberController@friends')->name('friends');

    Route::post('buddies/remove/{member}', 'MemberController@removeBuddy')->name('removeBuddy')->where('member', '[0-9]+}');

    //Tickets
    Route::post('buyTicket', 'EventController@buyTicket');

    Route::get('invoice/{id}', function($id){
        $invoice = Invoice::find($id);
        $query = MemberController::getinvoices($id);
        return view('pages.events.invoice', ['invoice' => $invoice, 'query' => $query[0]]);
    })->where('id', '[0-9]+');

    Route::post('ajax/events/inviteMember', 'EventController@inviteMember')->name('inviteEvent');
   
    //Event Admin
    Route::group(['middleware' => 'App\Http\Middleware\EventAdminMiddleware'], function(){
        Route::get('events/{event}/edit', 'EventController@editForm')->name('editEventForm')->where('event', '[0-9]+');
        Route::patch('events/{event}', 'EventController@edit')->name('editEvent');
        Route::delete('events/{event}', 'EventController@delete')->name('deleteEvent');
    });

    //Community Admin
    Route::group(['middleware' => 'App\Http\Middleware\CommunityAdminMiddleware'], function(){
        Route::get('communities/{community}/edit', 'CommunityController@editForm')->name('editCommunity')->where('community', '[0-9]+');
        Route::patch('communities/{community}/edit', 'CommunityController@edit')->name('editCommunity');
        Route::delete('communities/{community}', 'CommunityController@delete')->name('deleteCommunity');
    });

      //Administration
     Route::group(['middleware' => 'App\Http\Middleware\AdminMiddleware'], function(){
        Route::get('administration', 'AdminController@index')->name('administration');
    });
});


// Comments
Route::get('ajax/events/comments', 'CommentController@showEventComments');

// Communities
Route::get('communities/{community}', 'CommunityController@show')->name('community')->where('community', '[0-9]+')->middleware('App\Http\Middleware\CommunityMiddleware');

// Events
Route::get('events', 'EventController@index')->name('events');
Route::get('events/{event}', 'EventController@show')->name('event')->where('event', '[0-9]+')->middleware('App\Http\Middleware\EventMiddleware');

// Members
//Route::get('members', 'MemberController@index')->name('members');
Route::get('members/{username}', 'MemberController@show')->name('member')->where('username', '\w{3,}');

Route::post('mail', 'MailController@mail')->name('mail');

// Auth
Route::get('login', 'Auth\LoginController@showLoginForm')->name('login');
Route::post('login', 'Auth\LoginController@login');
Route::get('register', 'Auth\RegisterController@showRegistrationForm')->name('register');
Route::post('register', 'Auth\RegisterController@register');
Route::get('logout', 'Auth\LoginController@logout')->name('logout');


// Pass Reset
Route::get('password/reset', 'Auth\ForgotPasswordController@showLinkRequestForm')->name('password.request');
Route::post('password/email', 'Auth\ForgotPasswordController@sendResetLinkEmail')->name('password.email');


// Email Reset sent
Route::get('password/reset/{token}', 'Auth\ResetPasswordController@showResetForm')->name('password.reset');
Route::post('password/reset', 'Auth\ResetPasswordController@reset')->name('password.change');


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