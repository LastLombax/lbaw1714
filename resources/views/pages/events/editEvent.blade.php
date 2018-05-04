@extends('layout')

@section('title')
    Edit {{$event->name}}
@endsection

@section('titleIcon')
    <i class="fas fa-calendar-check"></i>
@endsection

@section('pageTitle')
    Edit - {{$event->name}}
@endsection

@section('content')
    <form action="{{ route('editEvent', $event)}}" method="POST" enctype="multipart/form-data">

        {{ method_field('PATCH') }}
        {{ csrf_field() }}

        <div class="row align-items-center">


            <div class="col-xl-5 align-self-start" style="padding-top: 25px;">
                <div class="bs-ccomponent">
                    <div style="background-color: #eee; padding: 20px; padding-top: 10px; border: 1px solid #ccc; box-shadow: 1px 1px 30px #ddd;">
                        <fieldset>
                            <div class="form-group">
                                <label class="col-form-label" for="name">
                                    <b>Event Name</b>
                                </label>
                                <input id="name" name="name" type="text" style="width:100%;"
                                       class="form-control col-xs-3" value="{{$event->name}}"
                                       placeholder="Enter event name" maxlength="80">
                            </div>

                            <label class="col-form-label" for="description" style="width:100%;">
                                <b>Description</b>
                                <div class="form-inline form-group mb-2" style="width:100%;">
                                    <textarea id="description" name="description" name="description"
                                              class="form-control" placeholder="Description" maxlength="255"
                                              style="width:100%;">{{$event->description}}</textarea>
                                </div>
                            </label>

                            <label class="col-form-label" for="startDate" style="width:100%;">
                                <b>Start date</b>
                                <div class="form-inline form-group mb-2" style="width:100%;">
                                    <input id="startDate" name="startDate" type="text" style="margin-right:0.25em"
                                           value="{{$event->startday}}" class="form-control col-lg-8"
                                           style="width:100%;">
                                    <input name="startTime" type="time" value="{{$event->starttime}}"
                                           class="form-control col-lg-3" placeholder="Start time" id="inputDefault"
                                           style="width:100%;">
                                </div>
                            </label>

                            <label class="col-form-label" for="endDate" style="width:100%;">
                                <b>End date</b>
                                <div class="form-inline form-group mb-2" style="width:100%;">
                                    <input id="endDate" name="endDate" type="date" style="margin-right:0.25em"
                                           class="form-control col-lg-8" value="{{$event->endday}}" style="width:100%;">
                                    <input id="endTime" name="endTime" type="time" value="{{$event->endtime}}"
                                           class="form-control col-lg-3" placeholder="End time" style="width:100%;">
                                </div>
                            </label>
                            <br>

                            <label class="col-form-label" for="country" style="width:100%;">
                                <b>Country</b>
                                <div class="form-inline form-group mb-2" style="width:100%;">
                                    <div class="form-group">
                                        <select id="country" name="country" class="form-control" required>
                                            <option value="">Choose</option>
                                            @foreach(App\Country::all() as $country)
                                                @if($event->country->idcountry == $country->idcountry)
                                                    <option value="{{$country->idcountry}}" selected>{{$country->name}}</option>
                                                @else
                                                    <option value="{{$country->idcountry}}"> {{$country->name}}</option>
                                                @endif
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                            </label>

                            <label class="col-form-label" for="visibility">
                                <b>Event visibility</b>
                                <br>
                                <div class="form-group">
                                    <select id="visibility" name="visibility" class="form-control">
                                        @if($event->isPublic)
                                            <option value="true" selected="selected">Public</option>
                                            <option value="false">Private</option>
                                        @else
                                            <option value="true">Public</option>
                                            <option value="false" selected="selected">Private</option>

                                        @endif
                                    </select>
                                </div>
                            </label>
                        </fieldset>
                    </div>
                </div>
            </div>

            <div class="col-xl-4 align-self-start" style="padding-top: 25px;">
                <div class="bs-ccomponent">

                    <div style="background-color: #eee; padding: 20px; padding-top: 10px; border: 1px solid #ccc; box-shadow: 1px 1px 30px #ddd;">
                        <fieldset style=" margin-bottom:51.3px;">
                            <div class="form-group">
                                <label class="col-form-label" for="address">
                                    <b>Location</b>
                                </label>
                                <input id="address" name="address" type="text" class="form-control"
                                       value="{{$event->address}}"
                                       placeholder="Example: Casa da Música, Porto, Portugal" maxlength="60">
                            </div>

                            <div class="form-group">
                                <label class="col-form-label" for="city">
                                    <b>City</b>
                                </label>
                                <input id="city" name="city" type="text" class="form-control" value="{{$event->city}}"
                                       placeholder="Example: Funchal, Lisboa, Porto" maxlength="5f0" required>
                            </div>

                            <div class="form-group">
                                <label class="col-form-label" for="lodging">
                                    <b>Lodging link</b>
                                </label>
                                <input id="lodging" name="lodging" type="text" class="form-control"
                                       placeholder="Enter lodging link">
                            </div>

                            <div class="form-group">
                                <label class="col-form-label" for="venue">
                                    <b>Venue Information</b>
                                </label>
                                <input id="venue" name="venue" type="text" class="form-control"
                                       placeholder="Venue information" maxlength="100">
                            </div>
                        </fieldset>
                    </div>
                </div>
            </div>
            @include('partials.uploadImage')
        </div>
        <button type="submit" class="btn btn-primary d-block ml-auto mt-3">Edit</button>
    </form>
    </div>
@endsection