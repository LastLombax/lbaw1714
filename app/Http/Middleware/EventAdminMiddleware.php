<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class EventAdminMiddleware
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
        $result = DB::table('event_member')->where([['idmember', '=', Auth::id()], ['idevent', '=', $request->event->idevent]])->first();
        
        if (! ($result != null && $result->isadmin))
			return redirect()->route('homepage');
        
        return $next($request);
    }
}
