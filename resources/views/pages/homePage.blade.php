{{--@foreach(\App\Http\Controllers\EventController::topEvents() as $event)--}}
    {{--{{$event}}--}}
{{--@endforeach--}}

@extends('layout')

@section('afterNav')
    @include('internal.timeline')
@endsection

@section('content')
    <br>

    <div class="container " style="padding-bottom: -30px; ">
        <div class="row justify-content-center align-items-center">
            <div class="col-lg-4 align-self-start">
                <div class="bs-ccomponent ">
                    <div class="card mb-3 " style="box-shadow: 1px 1px 5px #ddd; ">
                        <h3 class="card-header " style="border-bottom: 10px solid #158cb8 ">Upcoming Events</h3>
                        @include('pages.events.upcomingEventFragment')
                    </div>                </div>
            </div>
            <div class="col-lg-4 align-self-start">
                <div class="bs-ccomponent ">
                    <div class="card mb-3 " style="box-shadow: 1px 1px 5px #ddd; ">
                        <h3 class="card-header " style="border-bottom: 10px solid #158cb8 ">Top Events</h3>
                        @include('pages.events.topEventsFragment')
                    </div>
                </div>
            </div>
            <div class="col-lg-4 align-self-start">
                <div class="bs-ccomponent ">
                    <div class="card mb-3 " style="box-shadow: 1px 1px 5px #ddd; ">
                        <h3 class="card-header " style="border-bottom: 10px solid #f36833 ">Top Communities</h3>
                        @include('pages.communities.topCommunitiesFragment')
                    </div>
                </div>
            </div>
            <div class="col ">
                <br>
                <div class="jumbotron " style="padding: 25px ">
                    <h1 class="display-5 ">Questions?</h1>
                    <p class="lead ">Need help? This is just a bit of what our platform has to offer. You can see events, join them, buy tickets, be part
                        of a community and much more. Besides this you might need more help to understand all about! Consult our FAQ pages.
                    </p>
                    <p class="lead ">
                        <a class="btn btn-primary btn-lg " href="faq" role="button ">Take me there</a>
                    </p>
                </div>
            </div>
        </div>
@endsection