<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class CommunityMiddleware
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
        if (!$request->community->ispublic){
            
            $result = DB::table('community_member')->where([['idmember', '=', Auth::id()], ['idcommunity', '=', $request->community->idcommunity]])->get();
            if (sizeof($result) == 0)
                return redirect()->route('homepage');
        }
        
        return $next($request);
    }
}
