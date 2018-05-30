@extends('layout')

@section('extraScript')
    <script src="{{ asset('js/inviteFriends.js') }}" defer></script>
    <script src="{{ asset('js/inviteFriendToCommunity.js') }}" defer></script>
@endsection

@section('titleIcon')
    <i class="fas fa-users"></i>
@endsection

@section('pageTitle')
    <b>{{$community->name}}'s</b> Community
@endsection

@section('content')

    <div class="bs-docs-section">
        <div class="row">
            <div class="col-lg-4" style="padding-top: 23px;">
                <div class="bs-ccomponent">
                    <img src="{{$community->imagepath}}" style="width: 100%; height: 200px; object-fit: cover;">
                    <br>
                    <br>

                    <div class="col-lg-12" style="padding-left: 0; padding-right: 0;">
                        <div class="bs-ccomponent">
                            <div style="background-color: #eee; padding: 20px; padding-top: 10px;">
                                <fieldset>
                                    <div class="form-group">
                                        <label class="col-form-label" for="inputDefault">
                                            <b>Description</b>
                                        </label>
                                        <p>{{$community->description}}
                                        </p>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-form-label" for="inputDefault">
                                            <b>Membership details</b>
                                        </label>
                                        <p>
                                            <a href="#" style="color: #f3a933dc"> {{$community->numMembers()}}
                                                @if($community->numMembers() == 1) member
                                                @else members
                                                @endif</a>
                                        </p>
                                    </div>
                                   
                                    <div class="form-group">
                                        <label class="col-form-label" for="inputDefault">
                                            <b>Created on</b>
                                        </label>
                                        <p>{{$community->printDate()}}</p>
                                    </div>
                                </fieldset>
                                @if(!\Illuminate\Support\Facades\Auth::guest())
                                    <button style="width: 130px; margin-bottom: 2px;" type="button" class="btn btn-info" data-toggle="modal" data-target="#modalInvite">
                                        Invite Friends
                                    </button>
                                @endif
                                <br>
                                 @can('community-admin', $community)

                                    <button style="background-color: #f3a933dc; border-color: #f5956f; margin-top:5px;" type="submit" onclick="window.location='/communities/{{$community->idcommunity}}/edit'"
                                        class="btn btn-info">Edit Community
                                    </button>

                                    <form action="{{ route('deleteCommunity', $community) }}" method="post">
                                    <input type="hidden" name="_method" value="delete"/>
                                    {{ csrf_field() }}

                                    <button style="background-color: #f3a933dc; border-color: #f5956f; margin-top:5px;" type="submit" class="btn btn-info">Delete community </button>

                                    </button>
                                    </form>

                                    <form action="{{ route('createEvent')}}" method="get">
                                    <input type="hidden" name="community" value="{{$community->idcommunity}}"/>
                                        {{ csrf_field() }}

                                    <button style="background-color: #f3a933dc; border-color: #f5956f; margin-top:5px;" type="submit" class="btn btn-info">
                                    Create an event for the community </button>

                                    </button>
                                    </form>


                                @endcan
                                <br>
                                @if($community->ispublic)
                                        <span style="float: right"  class="badge badge-success">Public</span>
                                    @else
                                        <span style="float: right" class="badge badge-danger">Private</span>
                                    @endif
                            </div>
                            <div class="progress">
                                <div class="progress-bar" role="progressbar"
                                     style="width: 100%; background-color: #f36833;" aria-valuenow="100"
                                     aria-valuemin="0"
                                     aria-valuemax="100"></div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="col-lg-8" style="padding-top:23px">
                <ul class="nav nav-tabs">
                  
                    <li class="nav-item">
                        <a class="nav-link active" data-toggle="tab" href="#upcoming" style="color: #f36833">Upcoming
                            Events</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#history" style="color: #f36833">Event History</a>
                    </li>
                </ul>

                <div id="communityTab" class="tab-content">
                    
                    <div class="tab-pane fade show active" id="upcoming">
                        <div class="col-lg-12" style="padding-left: 0px;padding-right: 0px;">
                            <div class="bs-ccomponent">
                                <div class="list-group">

                                    @include('pages.communities.communityUpcoming', ['$community' => $community->idcommunity])

                                </div>

                            </div>
                        </div>
                        <div style="margin-top: 1rem; margin-left: 0;">
                            <ul class="pagination ">
                                <li class="page-item disabled ">
                                    <a class="page-link " href="# ">&laquo;</a>
                                </li>
                                <li class="page-item active ">
                                    <a class="page-link " href="# "
                                       style="background-color:#f36833; border-color:#f36833;">1</a>
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
                    <div class="tab-pane fade" id="history">
                        <div class="col-lg-12" style="padding-left: 0px;padding-right: 0px;">
                            <div class="bs-ccomponent">
                                <div class="list-group">

                                    @include('pages.communities.communityHistory', ['$community' => $community->idcommunity])

                                </div>
                            </div>
                        </div>
                        <div style="margin-top: 1rem; margin-left: 0;">
                            <ul class="pagination ">
                                <li class="page-item disabled ">
                                    <a class="page-link " href="# ">&laquo;</a>
                                </li>
                                <li class="page-item active ">
                                    <a class="page-link " href="# "
                                       style="background-color:#f36833; border-color:#f36833;">1</a>
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
    @include('pages.communities.partials.modals')
@endsection

