@extends('layout')

@section('content')
    <div class="container"> 
     <form method="POST" action="{{ route('createEvent') }}">
          {{ csrf_field() }}
        <div class="row align-items-center" style="border: 1px solid #ccc; width: 100%; margin: 0;">
   
            <div class="col-lg-6 align-self-start" style="padding-left: 0; padding-right:0;">
                <div class="bs-ccomponent">
                    <div style="background-color: #eee; padding: 20px; padding-top: 10px; height: 500px;">

           
                        <fieldset>
                            <div class="form-group">
                                <label class="col-form-label" for="eventName">
                                    <b>Event Name</b>
                                </label>
                                <input id="eventName" name ="eventName" required type="text" style="width:100%;" class="form-control col-xs-3" placeholder="Enter event name" maxlength="80">
                            </div>

                            <label class="col-form-label" for="eventDescription"  style="width:100%;">
                                <b>Description</b>
                                <div class="form-inline form-group mb-2" style="width:100%;">
                                    <textarea id="eventDescription" name ="eventDescription" required class="form-control" placeholder="Description" maxlength="255" style="width:100%;"> </textarea>
                                </div>
                            </label>

                            <label class="col-form-label" for="startday" style="width:100%;">
                                <b>Start date</b>
                                <div class="form-inline form-group mb-2" style="width:100%;">
                                    <input id="startday" name ="startday" required type="date" style="margin-right:0.25em" class="form-control col-lg-8" placeholder="March 4, 2018" style="width:100%;">
                                    <input id="starttime" name ="starttime" required type="time" class="form-control col-lg-3" placeholder="12:00 pm" style="width:100%;">
                                </div>
                            </label>

                            <label class="col-form-label" for="endday" style="width:100%;">
                                <b>End date</b>
                                <div class="form-inline form-group mb-2" style="width:100%;">
                                    <input id="endday" name ="endday" type="date" style="margin-right:0.25em" class="form-control col-lg-8" placeholder="March 4, 2018" style="width:100%;">
                                    <input id="endtime" name ="endtime" required type="time" class="form-control col-lg-3" placeholder="12:00 pm" style="width:100%;">
                                </div>
                            </label>


                            <br>
                            <label class="col-form-label" for="eventVisibility">
                                <b>Event visibility</b>
                                <br>
                                <div class="form-group">
                                    <select id="eventVisibility" name="eventVisibility" class="form-control" required>
                                        <option value="Public">Public</option>
                                        <option value="Private">Private</option>
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
                                <label class="col-form-label" for="eventAddress">
                                    <b>Location</b>
                                </label>
                                <input id="eventAddress" name = "eventAddress" type="text" class="form-control" placeholder="Example: Casa da Música, Porto, Portugal" maxlength="60"  required>
                            </div>

                            <div class="form-group">
                                <label class="col-form-label" for="lodging">
                                    <b>Lodging link</b>
                                </label>
                                <input id="lodging" name="lodging" type="text" class="form-control" placeholder="Enter lodging link" required>
                            </div>

                            <div class="form-group">
                                <label class="col-form-label" for="venue">
                                    <b>Venue Information</b>
                                </label>
                                <input id="venue" name="venue" type="text" class="form-control" placeholder="Venue information" maxlength="100" required>
                            </div>
                            <div class="form-group" id="imgField">
                                <label class="col-form-label" for="eventImage">
                                    <b>Image input</b>
                                </label>
                                <input id="eventImage" name="eventImage" type="file" class="form-control-file" aria-describedby="fileHelp">
                                <script>
                                    let fileName = document.querySelector('#eventImg').value;

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
       
    <button type="submit"  class="btn btn-primary d-block ml-auto mt-3">Create</button>
   
      </form>
    </div>

@endsection