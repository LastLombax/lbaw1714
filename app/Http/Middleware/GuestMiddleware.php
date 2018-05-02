<?php

namespace App\Http\Middleware;

use Closure;
use Auth;
class GuestMiddleware
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
        if (Auth::check()){
            dd("no u2"); 
        }
        return $next($request);
    }
}
