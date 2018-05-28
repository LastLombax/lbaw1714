<?php

namespace App\Http\Controllers;

use App\Comment;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    
    public function mail(){

        
        dd('Mail Send Successfully');

        Mail::send('emails.mailExample', $user, function($message) use ($user) {

            $message->to('lbaw201714@gmail.com');

            $message->subject('E-Mail Example');

        });


    }
}
