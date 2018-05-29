<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class EventMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {   
        if (!$request->event->ispublic){
            
            $result = DB::table('event_member')->where([['idmember', '=', Auth::id()], ['idevent', '=', $request->event->idevent]])->get();
            if (sizeof($result) == 0)
                return redirect()->route('homepage');
        }
        
        return $next($request);
    }
}
