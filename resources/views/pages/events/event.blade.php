@extends('layout')

@section('content')

<script type="text/javascript">

function confirmDeletion(form) {
    if (confirm("Are you sure you want to delete the event? \n WARNING: You cannot go back")) 
         form.submit();    
}
</script>

<div class="container">
    <legend style=" color: #333; padding: 0.3em; margin-left: 0; padding-left: 0;">
        <i class="fas fa-calendar-check"></i>
        <span style="margin-left: .5rem;">
            {{$event->name}}
        </span>
    </legend>
    <div class="row">

        <div class="col-lg-4" style="padding-top: 0;">
            <div class="bs-ccomponent">
                <img style="width: 100%; height: 200px; object-fit: cover;" src="{{$event->imagepath}}"
                     alt="Card image">
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
                                        {{$event->country}}
                                    </p>
                                </div>
                                <br>
                                @if(!\Illuminate\Support\Facades\Auth::guest())
                                    <div>
                                        <button type="button"
                                                onclick="event.preventDefault(); location.href = 'register2.html';"
                                                class="btn btn-info">Add me
                                        </button>
                                    </div>
                                    <br>
                                @endif
                                <div>
                                    <button type="button" onclick="event.preventDefault();" location.href = '';"
                                            class="btn btn-info">Buy Tickets
                                    </button>
                                    <button type="button" onclick="event.preventDefault();" location.href = '';"
                                            class="btn btn-info">Message the admins
                                    </button>

                                    <form action="{{ route('deleteEvent', $event) }}" method="post">
                                        <input type="hidden" name="_method" value="delete" />
                                        {{ csrf_field() }}
                                  
                                      <button type="submit" onClick="confirmDeletion(this.form);"
                                              class="btn btn-info">Delete this event
                                    </button>
                                      </form>
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
            <ul class="nav nav-tabs">
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="tab" href="#comments">Comments</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#participants">Participants</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#map">Location Map</a>
                </li>
            </ul>

            <div id="myTabContent" class="tab-content">
                <div class="tab-pane fade show active" id="comments">
                    <div class="col-lg-12" style="padding-left: 0px;padding-right: 0px;">
                        <div class="bs-ccomponent">
                            <div class="list-group">
                                @foreach($event->commentTuples as $comment)
                                    <div class="list-group-item list-group-item-action flex-column align-items-start">
                                        <div class="d-flex w-100 justify-content-between">
                                            <h5 class="mb-1">{{$comment->authorTuple->name}}</h5>
                                            <small>{{$comment->printDate()}}</small>
                                        </div>
                                        <p class="mb-1">{{$comment->text}}</p>
                                    </div>
                                @endforeach
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
                            <div class="list-group">
                                <a href="#"
                                   class="list-group-item list-group-item-action flex-column align-items-start">

                                    <img src="img/god.jpg"
                                         style="width: 20%; height: 100px; object-fit: cover; float:left;">
                                    <h5>God</h5>
                                </a>
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
                <div class="tab-pane fade" id="map">
                    <div class="col-lg-12" style="padding-left: 0px;padding-right: 0px;">
                        <div class="bs-ccomponent">
                            <div class="list-group">
                                @include('pages.events.geolocation')
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAr1_x1qNGarZz3rVGBTmTk2yDOAA-jkOI&callback=initMap">
</script>
@endsection

