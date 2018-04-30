@extends('layout')

@section('content')

    <div class="container">
        <legend style=" color: #333; padding: 20px; margin-left: 0; padding-left: 0; padding-bottom: 0;">
            <i class="fas fa-user"></i>
            <span style="margin-left: .5rem;">

          <b> {{$member->username}}'s</b> profile
            </span>
        </legend>

        <div class="bs-docs-section">
            <div class="row">


                <div class="col-lg-4" style="padding-top: 23px;">
                    <div class="bs-ccomponent">

                        <img src="{{Storage::url($member->profile)}}" style="width: 100%; height: 200px; object-fit: cover;">

                        <br>
                        <br>

                        <div class="col-lg-12" style="padding-left: 0; padding-right:0;">
                            <div class="bs-ccomponent">

                                <div style="background-color: #eee; padding: 20px; padding-top: 10px;">
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
                                            <p>{{$member->description}}</p>
                                        </div>
                                        @endif
                                          @if($member->birthdate != null )
                                        <div class="form-group">
                                            <label class="col-form-label" for="inputDefault">
                                                <b>Birthdate</b>
                                            </label>
                                            <p>{{$member->birthdate}}</p>
                                        </div>                                       
                                        @endif
                                        <div class="form-group">
                                            <label class="col-form-label" for="inputDefault">
                                                <b>Email address</b>
                                            </label>
                                            <p>
                                                <a href="#">{{$member->email}}</a>
                                            </p>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-form-label" for="inputDefault">
                                                <b>Address</b>
                                            </label>
                                            <p>
                                                <a href="#">{{$member->address}}, {{$member->city}}</a>
                                            </p>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-form-label" for="inputDefault">
                                                <b>Country</b>
                                            </label>
                                            <p>{{$member->country}}</p>
                                        </div>
                                    <br>
                                    <br>
                                    <br>
                                    <br>
                                    <div style="text-align: right;">
                                        <span class="badge badge-dark">Administrator</span>
                                    </div>
                                </fieldset></div>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-8" style="padding-top:23px">
                    <ul class="nav nav-tabs">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#feed">Notifications</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#upcoming">Upcoming Events</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#history">Event History</a>
                        </li>
                    </ul>

                    <div id="myTabContent" class="tab-content">
                        <div class="tab-pane fade show active" id="feed">
                            <div class="col-lg-12" style="padding-left: 0px;padding-right: 0px;">
                                <div class="bs-ccomponent">
                                    <div class="list-group">
                                    
                                        @include('pages.members.profileFeed', ['$member' => $member->id])

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="upcoming">
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
                </div>
                <div style="margin-top: 1rem; margin-left: 0;">
                    <ul class="pagination" style="">
                        <li class="page-item disabled ">
                            <a class="page-link " href="# ">«</a>
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
                            <a class="page-link " href="# ">»</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

       
</div>
@endsection

