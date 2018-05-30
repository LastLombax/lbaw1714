@extends('layout')

@section('extraScript')
    <script defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAr1_x1qNGarZz3rVGBTmTk2yDOAA-jkOI&callback=initMap">
    </script>
    <script src="{{ asset('js/commentScripts.js') }}" defer></script>
    <script src="{{ asset('js/buyTicketsScript.js') }}" defer></script>
    <script src="{{ asset('js/inviteFriends.js') }}" defer></script>
    <script src="{{ asset('js/inviteFriendToEvent.js') }}" defer></script>
    <script src="{{ asset('js/addMeToEvent.js') }}" defer></script>
    
@endsection


@section('titleIcon')
    <i class="fas fa-calendar-check"></i>
@endsection

@section('pageTitle')
    {{{$event->name}}}
@endsection

@section('content')

    <span id="eventID" hidden>{{$event->idevent}}</span>

    <div class="row">

        <div class="col-lg-4" style="padding-top: 0; padding-bottom: 50px;">
            <div class="bs-ccomponent">
                <img style="width: 100%; height: 200px; object-fit: cover;" src="{{$event->imagePath()}}"
                     alt="Event image">
                <br>
                <br>

                <div class="col-lg-12" style="padding-left: 0; padding-right:0;">
                    <div class="bs-ccomponent">

                        <div style="background-color: #eee; padding: 20px; padding-top: 10px;">
                            <fieldset>

                                <div class="form-group">
                                    <label class="col-form-label" for="inputDefault">
                                        <b>Description</b>
                                    </label>
                                    <p>{{$event->description}}</p>
                                </div>

                                <div class="form-group">
                                    <label class="col-form-label" for="inputDefault">
                                        <b>Date</b>
                                    </label>
                                    <p>
                                        {{$event->printDate()}}
                                    </p>
                                </div>

                                <div class="form-group">
                                    <label class="col-form-label" for="inputDefault">
                                        <b>Location</b>
                                    </label>
                                    <p id="address">
                                        {{$event->address}}, {{$event->city}}
                                    </p>
                                </div>

                                <div class="form-group">
                                    <label class="col-form-label" for="inputDefault">
                                        <b>Country</b>
                                    </label>
                                    <p id="country">
                                        {{$event->country->name}}
                                    </p>
                                </div>
                                <br>
                                @if(!\Illuminate\Support\Facades\Auth::guest())
                                    <div>
                                        @if(!$event->isMemberAdded())
                                            <div id="addMeBt">
                                                <button style="width: 130px; margin-bottom: 2px;" type="button"
                                                        onclick="addMeToEvent();"
                                                        class="btn btn-info">Add me
                                                </button>
                                            </div>
                                        @endif
                                        <button style="width: 130px; margin-bottom: 2px;" type="button" class="btn btn-info" data-toggle="modal"
                                                data-target="#modalInvite">
                                            Invite Friends
                                        </button>
                                    </div>
                                @endif
                                <div>
                                    @if(!\Illuminate\Support\Facades\Auth::guest())
                                        <button style="width: 130px; margin-bottom: 2px;" type="button" class="btn btn-info" data-toggle="modal"
                                                data-target="#modalBuyTicket">
                                            Buy Tickets
                                        </button>

                                        <br>

                                    @can('event-admin', $event)

                                    <button style="width: 130px; margin-bottom: 2px" type="submit" onclick="window.location='/events/{{$event->idevent}}/edit'"
                                            class="btn btn-info">Edit Event
                                    </button>
                                    
                                    <form action="{{ route('deleteEvent', $event) }}" method="post">
                                        <input type="hidden" name="_method" value="delete"/>
                                        {{ csrf_field() }}

                                        <button style="width: 130px; margin-bottom: 2px" type="submit" class="btn btn-info">Delete event </button>
                                    </form>
                                        @endcan
                                    @endif
                                        <br>

                                    @if($event->ispublic)
                                        <span style="float: right" class="badge badge-success">Public</span>
                                    @else
                                        <span style="float: right" class="badge badge-danger">Private</span>
                                    @endif
                                </div>
                            </fieldset>
                        </div>

                        <div class="progress">
                            <div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="100"
                                 aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-8" style="padding-top:0;">

            <div id="map" style="margin-bottom: 30px;">
                @include('pages.events.geolocation')
            </div>

            <ul class="nav nav-tabs">
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="tab" href="#comments">Comments</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#participants">Participants
                        @if ($event->numMembers() >= 100)
                            (100+)
                        @else
                            ({{$event->numMembers()}})
                        @endif
                    </a>
                </li>
            </ul>

            <div id="myTabContent" class="tab-content">
                <div class="tab-pane fade show active" id="comments">
                    <div class="col-lg-12" style="padding-left: 0px;padding-right: 0px;">
                        <div class="bs-ccomponent">
                            <div id="comments-container" class="list-group">

                            </div>

                            @if(Auth::guest())
                                <div hidden style="border: 1px solid #ddd; padding: 15px; border-bottom-left-radius: 8px; border-bottom-right-radius: 8px;">
                            @else
                                <div  style="border: 1px solid #ddd; padding: 15px; border-bottom-left-radius: 8px; border-bottom-right-radius: 8px;">
                            @endif


                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <input style="border: 0; width: 100%; height: 35.7px; text-align: left; font-size: 14px" type="text" id ="createComment" placeholder="Write a comment...">
                                            </td>
                                            <td style="text-align: right">
                                                <button style=" border-radius: 5px; " id="insertCommentBt" type="button" class="btn btn-outline-primary">Send</button>

                                            </td>
                                        </tr>
                                    </table>
                                </div>

                        </div>
                    </div>
                    <div style="margin-top: 1rem; margin-left: 0;">
                        <ul class="pagination ">
                            <li class="page-item disabled ">
                                <a class="page-link " href="# ">&laquo;</a>
                            </li>
                            <li class="page-item active ">
                                <a class="page-link " href="# ">1</a>
                            </li>
                            <li class="page-item ">
                                <a class="page-link " href="# ">2</a>
                            </li>
                            <li class="page-item ">
                                <a class="page-link " href="# ">3</a>
                            </li>
                            <li class="page-item ">
                                <a class="page-link " href="# ">&raquo;</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="tab-pane fade" id="participants">
                    <div class="col-lg-12" style="padding-left: 0px;padding-right: 0px;">
                        <div class="bs-ccomponent">
                            @each('pages.events.partials.participant', $event->attendants, 'member') {{--TODO ADD partial if collection is empty--}}
                        </div>
                    </div>
                    <div style="margin-top: 1rem; margin-left: 0;">
                        <ul class="pagination ">
                            <li class="page-item disabled ">
                                <a class="page-link " href="# ">&laquo;</a>
                            </li>
                            <li class="page-item active ">
                                <a class="page-link " href="# ">1</a>
                            </li>
                            <li class="page-item ">
                                <a class="page-link " href="# ">2</a>
                            </li>
                            <li class="page-item ">
                                <a class="page-link " href="# ">3</a>
                            </li>
                            <li class="page-item ">
                                <a class="page-link " href="# ">&raquo;</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    @include('pages.events.partials.modals')
@endsection

