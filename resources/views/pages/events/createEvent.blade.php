@extends('layout')

@section('extraScript')
    <script src="{{ asset('js/displaySubmitedImage.jsg') }}" defer></script>
@endsection

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
                                <label class="col-form-label" for="name">
                                    <b>Event Name</b>
                                </label>
                                <input id="name" name ="name" required type="text" style="width:100%;" class="form-control col-xs-3" placeholder="Enter event name" maxlength="80">
                            </div>

                            <label class="col-form-label" for="description"  style="width:100%;">
                                <b>Description</b>
                                <div class="form-inline form-group mb-2" style="width:100%;">
                                    <textarea id="description" name ="description" required class="form-control" placeholder="Description" maxlength="255" style="width:100%;"> </textarea>
                                </div>
                            </label>

                            <label class="col-form-label" for="startDate" style="width:100%;">
                                <b>Start date</b>
                                <div class="form-inline form-group mb-2" style="width:100%;">
                                    <input id="startDate" name ="startDate" required type="date" style="margin-right:0.25em" class="form-control col-lg-8" placeholder="March 4, 2018" style="width:100%;">
                                    <input id="startTime" name ="startTime" required type="time" class="form-control col-lg-3" placeholder="12:00 pm" style="width:100%;">
                                </div>
                            </label>

                            <label class="col-form-label" for="endDate" style="width:100%;">
                                <b>End date</b>
                                <div class="form-inline form-group mb-2" style="width:100%;">
                                    <input id="endDate" name ="endDate" type="date" style="margin-right:0.25em" class="form-control col-lg-8" placeholder="March 4, 2018" style="width:100%;">
                                    <input id="endTime" name ="endTime" required type="time" class="form-control col-lg-3" placeholder="12:00 pm" style="width:100%;">
                                </div>
                            </label>
                            <label class="col-form-label" for="country" style="width:100%;">
                                <b>Country</b>
                                <div class="form-inline form-group mb-2" style="width:100%;">
                                    @include('layouts.countrySelector')
                                </div>
                            </label>

                            <label class="col-form-label" for="visibility">
                                <b>Event Visibility</b>
                                <br>
                                <div class="form-group">
                                    <select id="visibility" name="visibility" class="form-control" required>
                                        <option value="true">Public</option>
                                        <option value="false">Private</option>
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
                                <input id="address" name = "address" type="text" class="form-control" placeholder="Example: Casa da Música, Porto, Portugal" maxlength="60"  required>
                            </div>

                            <div class="form-group">
                                <label class="col-form-label" for="city">
                                    <b>City</b>
                                </label>
                                <input id="city" name = "city" type="text" class="form-control" placeholder="Example: Funchal, Lisboa, Porto" maxlength="50"  required>
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
                                <input id="imagePath" name="imagePath" type="file" class="form-control-file" aria-describedby="fileHelp">
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