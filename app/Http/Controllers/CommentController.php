<?php

namespace App\Http\Controllers;

use App\Comment;
use App\Event;
use http\Env\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;

class CommentController extends Controller
{


    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Comment  $comment
     * @return \Illuminate\Http\Response
     */
    public function showEventComments(Request $request)
    {
        $event = Event::find($request->idEvent);
        if(Gate::denies('event-view', $event))
            return Response([], 403);

        $comments = $event->commentTuples;

        foreach ($comments as $comment){
            $comment->isAuthor = Auth::id() == $comment->author;
            $comment->authorName = $comment->authorTuple->name;
            $comment->username = $comment->authorTuple->username;
            $comment->date = $comment->printDate();
        }

        return $comments;
    }



    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Comment  $comment
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Comment $comment)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Comment  $comment
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request)
    {
         $comment = Comment::find($request->idComment);


        if ($comment->author == Auth::id())
            $comment->delete();

        return Request(200);
    }
}
