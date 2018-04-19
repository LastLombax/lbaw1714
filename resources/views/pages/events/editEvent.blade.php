@extends('layout')

@section('title')
   Edit {{$event->name}}
@endsection

@section('titleIcon')
    <i class="fas fa-calendar-check"></i>
@endsection

@section('pageTitle')
    {{$event->name}}
@endsection

@section('content')
<div class="container">
    <br>
    <legend style=" color: #333; padding: 20px; margin-left: 0; padding-left: 0; padding-bottom: 10px;">
      <i class="fas fa-calendar-check"></i>
       Edit Event
    </legend>

      <form action="{{ route('editEvent', $event)}}" method="POST">
      {{--{{ method_field('PATCH') }}--}}
      {{ csrf_field() }}

      <div class="row align-items-center" style="border: 1px solid #ccc; width: 100%; margin: 0;">


          <div class="col-lg-6 align-self-start" style="padding-left: 0; padding-right:0;">
            <div class="bs-ccomponent">
              <div style="background-color: #eee; padding: 20px; padding-top: 10px; height: 500px;">
                <fieldset>
                  <div class="form-group">
                    <label class="col-form-label" for="name">
                      <b>Event Name</b>
                    </label>
                    <input  id="name" name="name" type="text" style="width:100%;" class="form-control col-xs-3" value="{{$event->name}}" placeholder="Enter event name" maxlength="80">
                  </div>

                  <label class="col-form-label" for="description"  style="width:100%;">
                    <b>Description</b>
                    <div class="form-inline form-group mb-2" style="width:100%;">
                      <textarea id="description" name="description" name="description" class="form-control" placeholder="Description" maxlength="255" style="width:100%;">{{$event->description}}</textarea>
                    </div>
                  </label>

                  <label class="col-form-label" for="startday" style="width:100%;">
                    <b>Start date</b>
                    <div class="form-inline form-group mb-2" style="width:100%;">
                      <input id="startday" name ="startday" type="text" style="margin-right:0.25em" value="{{$event->startday}}" class="form-control col-lg-8" style="width:100%;">
                      <input name="startTime" type="time" value ="{{$event->starttime}}" class="form-control col-lg-3" placeholder="Start time" id="inputDefault" style="width:100%;">
                    </div>
                  </label>

                  <label class="col-form-label" for="endday" style="width:100%;">
                    <b>End date</b>
                    <div class="form-inline form-group mb-2" style="width:100%;">
<<<<<<< HEAD
                      <input id="endday" name="endday" type="date" style="margin-right:0.25em" class="form-control col-lg-8" value="{{$event->endday}}" style="width:100%;"> 
                      <input id="endtime" name="endtime" type="time" value ="{{$event->endtime}}" class="form-control col-lg-3" placeholder="End time" style="width:100%;">
                    </div>
                  </label>
                  <br>
                  <label class="col-form-label" for="visibility">
=======
                      <input name="endDate" type="date" style="margin-right:0.25em" class="form-control col-lg-8" value="{{$event->endday}}" id="inputDefault" style="width:100%;">
                      <input name="endTime" type="time" value ="{{$event->endtime}}" class="form-control col-lg-3" placeholder="End time" id="inputDefault" style="width:100%;">
                    </div>
                  </label>
                  <br>
                  @include('layouts.countrySelector')
                  <label class="col-form-label" for="inputDefault">
>>>>>>> 0383950cf5dcb824618f662f6a1fccb4e3849154
                    <b>Event visibility</b>
                    <br>
                    <div class="form-group">
                      <select id="visibility" name="visibility" class="form-control" >
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


          <div class="col-lg-6 align-self-start" style="padding-left: 0; padding-right:0;">
            <div class="bs-ccomponent">

              <div style="background-color: #eee; padding: 20px; padding-top: 10px; height: 500px;">
                <fieldset style=" margin-bottom:51.3px;">
                  <div class="form-group">
                    <label class="col-form-label" for="address">
                      <b>Location</b>
                    </label>
                    <input id="address" name="address" type="text" class="form-control" value="{{$event->address}}" placeholder="Example: Casa da Música, Porto, Portugal" maxlength="60">
                  </div>

                  <div class="form-group">
                    <label class="col-form-label" for="lodging">
                      <b>Lodging link</b>
                    </label>
                    <input id="lodging" name="lodging" type="text"class="form-control" placeholder="Enter lodging link" >
                  </div>

                  <div class="form-group">
                    <label class="col-form-label" for="venue">
                      <b>Venue Information</b>
                    </label>
                    <input id="venue" name="venue"type="text" class="form-control" placeholder="Venue information" maxlength="100">
                  </div>
                  <div class="form-group" id="imgField">
                    <label class="col-form-label" for="image">
                      <b>Image input</b>
                    </label>
                    <input t id="image" name="image" type="file" class="form-control-file" aria-describedby="fileHelp">
                    <script>                      
                      let fileName = document.querySelector('#eventImg').value;
                      console.log(fileName);
                      
                      let imgTag = document.createElement('img');
                      imgTag.className += "src=\"" + fileName + "\"";
                      
                      let imgField = document.querySelector('#imgField');
                      imgField.appendChild(imgTag);
                    </script>
                    <small id="fileHelp" class="form-text text-muted">Choose an event representative picture, such as a banner or photo of the venue</small>
                  </div>
                  <br>
                </fieldset>

              </div>

          </div>

        </div>

      </div>
       <button type="submit" class="btn btn-primary d-block ml-auto mt-3">Edit</button>
      </form>
    </div>
@endsection