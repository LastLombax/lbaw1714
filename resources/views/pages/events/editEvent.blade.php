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
      {{ method_field('PATCH') }}
      {{ csrf_field() }}

      <div class="row align-items-center" style="border: 1px solid #ccc; width: 100%; margin: 0;">


          <div class="col-lg-6 align-self-start" style="padding-left: 0; padding-right:0;">
            <div class="bs-ccomponent">
              <div style="background-color: #eee; padding: 20px; padding-top: 10px; height: 500px;">
                <fieldset>
                  <div class="form-group">
                    <label class="col-form-label" for="inputDefault">
                      <b>Event Name</b>
                    </label>
                    <input name="name" type="text" style="width:100%;" class="form-control col-xs-3" value="{{$event->name}}" placeholder="Enter event name" id="eventName" maxlength="80">
                  </div>

                  <label class="col-form-label" for="inputDefault"  style="width:100%;">
                    <b>Description</b>
                    <div class="form-inline form-group mb-2" style="width:100%;">
                      <textarea name="description" class="form-control" placeholder="Description" id="inputDefault"  maxlength="255" style="width:100%;">{{$event->description}}</textarea>
                    </div>
                  </label>

                  <label class="col-form-label" for="inputDefault" style="width:100%;">
                    <b>Start date</b>
                    <div class="form-inline form-group mb-2" style="width:100%;">
                      <input name="startDate" type="text" style="margin-right:0.25em" value="{{$event->startday}}" class="form-control col-lg-8" id="inputDefault" style="width:100%;">
                      <input name="startTime" type="time" value ="{{$event->starttime}}" class="form-control col-lg-3" placeholder="Start time" id="inputDefault" style="width:100%;">
                    </div>
                  </label>

                  <label class="col-form-label" for="inputDefault" style="width:100%;">
                    <b>End date</b>
                    <div class="form-inline form-group mb-2" style="width:100%;">
                      <input name="endDay" type="date" style="margin-right:0.25em" class="form-control col-lg-8" value="{{$event->endday}}" id="inputDefault" style="width:100%;"> 
                      <input name="endTime" type="time" value ="{{$event->endtime}}" class="form-control col-lg-3" placeholder="End time" id="inputDefault" style="width:100%;">
                    </div>
                  </label>
                  <br>
                  <label class="col-form-label" for="inputDefault">
                    <b>Event visibility</b>
                    <br>
                    <div class="form-group">
                      <select name="visibility" class="form-control" id="inputDefault">
                        @if($event->isPublic)
                            <option value="Public" selected="selected">Public</option>
                            <option value="Private">Private</option>                        
                        @else
                            <option value="Public"> Public</option>
                            <option value="Private" selected="selected">Private</option>
                        
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
                    <label class="col-form-label" for="inputDefault">
                      <b>Location</b>
                    </label>
                    <input type="text" name="address" class="form-control" value="{{$event->address}}" placeholder="Example: Casa da Música, Porto, Portugal" id="inputDefault" maxlength="60">
                  </div>

                  <div class="form-group">
                    <label class="col-form-label" for="inputDefault">
                      <b>Lodging link</b>
                    </label>
                    <input type="text" name="lodgingLink" class="form-control" placeholder="Enter lodging link" id="inputDefault">
                  </div>

                  <div class="form-group">
                    <label class="col-form-label" for="inputDefault">
                      <b>Venue Information</b>
                    </label>
                    <input type="text" class="form-control" placeholder="Venue information" id="inputDefault" maxlength="100">
                  </div>
                  <div class="form-group" id="imgField">
                    <label class="col-form-label" for="eventImg">
                      <b>Image input</b>
                    </label>
                    <input type="file" class="form-control-file" id="eventImg" aria-describedby="fileHelp">
                    <script>                      
                      let fileName = document.querySelector('#eventImg').value;
                      console.log(fileName);
                      
                      let imgTag = document.createElement('img');
                      imgTag.className += "src=\"" + fileName + "\"";
                      
                      let imgField = document.querySelector('#imgField');
                      imgField.appendChild(imgTag);
                    </script>
                    <small id="fileHelp" class="form-text text-muted">Choose a event representative picture, such as a banner or photo of the venue</small>
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