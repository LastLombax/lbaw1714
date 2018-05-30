<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class CommunityAdminMiddleware
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
        $result = DB::table('community_member')->where([['idmember', '=', Auth::id()], ['idcommunity', '=', $request->community->idcommunity]])->first();
        
        if (! ($result != null && $result->isadmin))
			return redirect()->route('homepage');
        
        return $next($request);
    }
}
