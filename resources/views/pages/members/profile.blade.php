@extends('layout')

@section('extraScript')
    <script src="{{ asset('js/memberProfile.js') }}" defer></script>
@endsection

@section('content')

@section('titleIcon')
    <i class="fas fa-user"></i>
@endsection

@section('pageTitle')
    <b> {{$member->username}}'s</b> profile
@endsection

<div class="row">

    <div class="col-lg-4" style="padding-top: 23px;">

        <img src="{{$member->imagePath()}}" style="width: 100%; height: 200px; object-fit: cover;">

        <br>
        <br>

        <div style="background-color: #eee; padding: 20px; padding-top: 10px; border: 1px solid #ccc; box-shadow: 1px 1px 30px #ddd;">
            <fieldset>
                <div class="form-group">
                    <label class="col-form-label" for="inputDefault">
                        <b>Name</b>
                    </label>
                    <p>{{$member->name}}</p>
                </div>
                @if($member->about != null)
                    <div class="form-group">
                        <label class="col-form-label" for="inputDefault">
                            <b>About</b>
                        </label>
                        <p>{{$member->about}}</p>
                    </div>
                @endif
                @if($member->birthdate != null )
                    <div class="form-group">
                        <label class="col-form-label" for="inputDefault">
                            <b>Birthdate</b>
                        </label>
                        <p>{{$member->printDate()}}</p>
                    </div>
                @endif
                <div class="form-group">
                    <label class="col-form-label" for="inputDefault">
                        <b>Email address</b>
                    </label>
                    <p>
                        <a href="mailto:{{$member->email}}">{{$member->email}}</a>
                    </p>
                </div>
                @if (Auth::id() == $member->idmember)

                    @if($member->address != null )
                        <div class="form-group">
                            <label class="col-form-label" for="inputDefault">
                                <b>Address</b>
                            </label>
                            <p>
                                @if($member->city != null )
                                    <a href="#">{{$member->address}}, {{$member->city}}</a>
                                @else
                                    <a href="#">{{$member->address}} </a>
                                @endif
                            </p>
                        </div>
                    @endif


                    <div class="form-group">
                        <label class="col-form-label" for="inputDefault">
                            <b>Country</b>
                        </label>
                        <p>{{$member->country->name}}</p>
                    </div>
                    <div style="float: right;">
                        <a class="dropdown-item" href=" {{route('editForm', $member)}}">
                            <i class="far fa-edit" style=" color: #333; "></i> Edit
                        </a>
                    </div>

                @endif

                @if(!\Illuminate\Support\Facades\Auth::guest())

                <?php
                if (Auth::id() != $member->idmember){
                    $friendAccepted = \App\Http\Controllers\MemberController::getFriendAcceptance($member->idmember);

                    if(sizeof($friendAccepted) != 0){
                        if(!$friendAccepted[0]->accepted){
                            echo'
                                <div style="float: left;">
                                    <form>
                                        <button type="submit" onclick="event.preventDefault();">
                                            <i class="fas fa-check"></i>
                                            Friend Request Sent
                                        </button>
                                    </form>
                                </div>';
                        }
                        else{
                            echo'
                                <div style="float: left;">
                                    <form>
                                        <button type="submit" onclick="event.preventDefault();">
                                            <i class="fas fa-user"></i>
                                            Friends
                                        </button>
                                    </form>
                                </div>';
                        }
                    }
                    else{
                        echo'
                            <div style="float: left;">
                                <form>
                                    <button class="befriendBtn" id="'.$member->idmember.'" type="submit">
                                        <i class="fas fa-user-plus" style=" color: #333;"></i>
                                        Befriend this Member
                                    </button>
                                </form>
                            </div>';
                    }
                }

                ?>
                @endif
            </fieldset>
            @if($member->isadmin())
                <div style="text-align: right;">
                    <span class="badge badge-dark">Administrator</span>
                </div>
            @endif
        </div>
    </div>


    <div class="col-lg-8" style="padding-top:23px">
        <ul class="nav nav-tabs">
            @if (Auth::id() == $member->idmember)
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="tab" href="#feed">Notifications</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#upcoming">Upcoming Events</a>
                </li>
            @else
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="tab" href="#upcoming">Upcoming Events</a>
                </li>
            @endif

            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#history">Event History</a>
            </li>

            @if (Auth::id() == $member->idmember)

                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#invoices">My Invoices</a>
                </li>
            @endif
        </ul>


        <div id="myTabContent" class="tab-content">
            @if (Auth::id() == $member->idmember)
                <div class="tab-pane fade show active" id="feed">
                    <div class="col-lg-12" style="padding-left: 0px;padding-right: 0px;">
                        <div class="bs-ccomponent">
                            <div class="list-group">

                                @include('pages.members.profileFeed', ['$member' => $member->idmember])

                            </div>
                        </div>
                    </div>
                </div>
            @endif
            @if (Auth::id() == $member->idmember)
                <div class="tab-pane fade" id="upcoming">

                    @else
                        <div class="tab-pane fade show active" id="upcoming">

                            @endif

                            <div class="col-lg-12" style="padding-left: 0px;padding-right: 0px;">
                                <div class="bs-ccomponent">
                                    <div class="list-group">

                                        @include('pages.members.profileUpcoming', ['$member' => $member->id])

                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="tab-pane fade" id="history">
                            <div class="col-lg-12" style="padding-left: 0px;padding-right: 0px;">
                                <div class="bs-ccomponent">
                                    <div class="list-group">

                                        @include('pages.members.profileHistory', ['$member' => $member->id])
                                    </div>
                                </div>
                            </div>
                        </div>

                        @if (Auth::id() == $member->idmember)
                            <div class="tab-pane fade" id="invoices">
                                <div class="col-lg-12" style="padding-left: 0px;padding-right: 0px;">
                                    <div class="bs-ccomponent">
                                        <div class="list-group">
                                            @include('pages.members.invoices', ['$member' => $member->id])
                                        </div>
                                    </div>
                                </div>
                            </div>
                        @endif

                </div>
        </div>
    </div>
</div>
@endsection

