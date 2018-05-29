<?php

namespace App\Http\Controllers;

use App\Comment;
use App\Event;
use http\Env\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\DB;

class CommentController extends Controller
{


    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public static function store(Request $request)
    {
        $user = Auth::id();

        try {
            DB::Insert('INSERT INTO comment (text, timestamp, event, author) VALUES (?, ?, ?, ?)',
            [$request->content, date('Y-m-d H:i:s'), $request->idEvent, $user]);
        }
        catch (QueryException $e) {
            return response("false",200);
        }
        return response("true",200);
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

        return $event->commentTuples;
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
