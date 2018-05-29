@extends('layout')

@section('extraScript')
    <script defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAr1_x1qNGarZz3rVGBTmTk2yDOAA-jkOI&callback=initMap">
    </script>
    <script src="{{ asset('js/commentScripts.js') }}" defer></script>
    <script src="{{ asset('js/buyTicketsScript.js') }}" defer></script>
    <script src="{{ asset('js/inviteFriends.js') }}" defer></script>

@endsection


@section('titleIcon')
    <i class="fas fa-calendar-check"></i>
@endsection

@section('pageTitle')
    {{{$event->name}}}
@endsection

@section('content')

    <span id="eventID" hidden>{{$event->idevent}}</span>

    <script type="text/javascript" defer>
        function confirmDeletion(form) {
            if (confirm("Are you sure you want to delete this event? \n WARNING: You cannot go back"))
                form.submit();
        }
    </script>

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
                                                <button type="button"
                                                        onclick="addMeToEvent();"
                                                        class="btn btn-info">Add me
                                                </button>
                                            </div>
                                        @endif
                                        <button type="button" class="btn btn-info" data-toggle="modal"
                                                data-target="#modalInvite">
                                            Invite Friends
                                        </button>
                                    </div>
                                    <br>
                                @endif
                                <div>
                                    @if(!\Illuminate\Support\Facades\Auth::guest())
                                        <button type="button" class="btn btn-info" data-toggle="modal"
                                                data-target="#modalBuyTicket">
                                            Buy Tickets
                                        </button>

                                        @can('event-admin', $event)
                                            <form action="{{ route('deleteEvent', $event) }}" method="post">
                                                <br>
                                                <input type="hidden" name="_method" value="delete"/>
                                                {{ csrf_field() }}

                                                <button type="submit" onClick="confirmDeletion(this.form);"
                                                        class="btn btn-info">Delete this event
                                                </button>
                                            </form>
                                        @endcan
                                    @endif

                                    @can('event-admin', $event)
                                        <div style="float: right;">
                                            <a class="dropdown-item" href=" {{route('editEventForm', $event)}}">
                                                <i class="far fa-edit" style=" color: #333; "></i> Edit
                                            </a>
                                        </div>
                                    @endcan
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
                            <div class="list-group">
                                <div class="list-group-item list-group-item-action flex-column align-items-start">
                                    <input type="text" style="width: 100%" id ="createComment" placeholder="Write a comment...">

                                    {{-- <textarea cols="200"></textarea> --}}
                                </div>

                                @foreach($event->commentTuples as $comment)
                                    <div class="list-group-item list-group-item-action flex-column align-items-start">
                                        <div class="d-flex w-100 justify-content-between">
                                           <h5 class="mb-1">{{$comment->authorTuple->name}}</h5>
                                            </a>

                                            <div class="commentActions"
                                                 style="font-size: 18px; text-align: right; color: #999">

                                                <button class="editComment" onmouseleave='this.style.color="#999"'
                                                        onmouseout='this.style.color="#666"' style="cursor: pointer;">
                                                    <i class="fas fa-pencil-alt"></i>
                                                    <span class="comment-id"
                                                          style="display: none">{{$comment->idcomment}}</span>
                                                </button>

                                                <button class="deleteComment" onmouseleave='this.style.color="#999"'
                                                        onmouseout='this.style.color="#666"' style="cursor: pointer;">
                                                    <i class="fas fa-trash-alt"></i>
                                                    <span class="comment-id"
                                                          style="display: none">{{$comment->idcomment}}</span>
                                                </button>

                                            </div>

                                        </div>
                                        <p class="mb-1">{{$comment->text}}</p>
                                        <small>
                                            {{$comment->printDate()}}
                                        </small>
                                    </div>
                                @endforeach

                            </div>
                            <textarea class="form-control" id="newComment" rows="2"></textarea>
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

