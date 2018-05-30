<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
    @section('title')
        ReEvent
    @endsection

    @if(\Illuminate\Support\Facades\Auth::guest())
            @include('layouts.visitorHead')
    @else
            @include('layouts.head')
    @endif

    <style>
        #map {
            height: 400px;
            width: 100%;
        }
    </style>
</head>
<body>

    @yield('myFriends')

    @if(Auth::guest())
        @include('layouts.visitorNav')
    @else
        @include('layouts.nav')
        @include('layouts.searchNavBar')
    @endif


    @yield('afterNav')

    @yield('searchBody')

    <div class="container">
        <div style="color: #333; padding: 1rem; margin-left: 0.5rem; padding-left: 0; padding-bottom: 0.5rem; font-size: x-large;">
            @yield('titleIcon')
            <span style="margin-left: .5rem;">
                    @yield('pageTitle')
            </span>
        </div>

            <section id="content">
                @yield('content')
            </section>
    </div>

    @include('layouts.footer')
</body>
</html>
