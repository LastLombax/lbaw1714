<?php

namespace App\Http\Controllers;

use App\Comment;
use Illuminate\Http\Request;
use Mail;
class MailController extends Controller{
    /** * Show the application dashboard. * * @return \Illuminate\Http\Response */
    public function mail(Request $request)
    {
        global $name, $email, $content;
        $name = $request->name;
        $email = $request->email;
        $content = $request->content;
        //  dd($content);
        //dd($this->validate($request, [ 'name' => 'required', 'email' => 'required|email', 'message' => 'required']));

        // ContactUS::create($request->all());

        Mail::send('contactEmail',
            array(
                'name' => $name,
                'email' => $email,
                'content' => $content
            ), function($message) {
                    global $name, $email, $content;
                    $message->from($email);
                    $message->to('lbaw201714@gmail.com', 'Admin')->subject('You have received a message from ' . $name);
        });

        return back()->with('success', 'Thanks for contacting us!');
    }
 }
