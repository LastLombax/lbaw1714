@extends('layout')

@section('title')
    {{--@dd($community);--}}
    {{$community->name}} | ReEvent
@endsection

@section('titleIcon')
    <i class="fas fa-calendar-check"></i>
@endsection

@section('pageTitle')
    {{$community->name}}
@endsection

@section('content')
<div class="container">
    <br>
    <legend style=" color: #333; padding: 20px; margin-left: 0; padding-left: 0; padding-bottom: 10px;">
      <i class="fas fa-calendar-check"></i>
       Edit community
    </legend>

      <form action="{{ route('createCommunity') }}" method="POST">
       <input type="hidden" name="_method" value="PUT">
      {{ csrf_field() }}

      <div class="row align-items-center" style="border: 1px solid #ccc; width: 100%; margin: 0;">


          <div class="col-lg-6 align-self-start" style="padding-left: 0; padding-right:0;">
            <div class="bs-ccomponent">
              <div style="background-color: #eee; padding: 20px; padding-top: 10px; height: 500px;">
                <fieldset>
                  <div class="form-group">
                    <label class="col-form-label" for="inputDefault">
                      <b>Community Name</b>
                    </label>
                    <input type="text" style="width:100%;" class="form-control col-xs-3" placeholder="Enter community name" id="communityName" maxlength="80">
                  </div>

                  <label class="col-form-label" for="inputDefault"  style="width:100%;">
                    <b>Description</b>
                    <div class="form-inline form-group mb-2" style="width:100%;">
                      <textarea  class="form-control" placeholder="Description" id="inputDefault" maxlength="255" style="width:100%;"> </textarea>
                    </div>
                  </label>

                  <label class="col-form-label" for="inputDefault" style="width:100%;">
                    <b>Start date</b>
                    <div class="form-inline form-group mb-2" style="width:100%;">
                      <input type="text" style="margin-right:0.25em" class="form-control col-lg-8" placeholder="March 4, 2018" id="inputDefault" style="width:100%;">
                      <input type="text" class="form-control col-lg-3" placeholder="12:00 pm" id="inputDefault" style="width:100%;">
                    </div>
                  </label>

                  <label class="col-form-label" for="inputDefault" style="width:100%;">
                    <b>End date</b>
                    <div class="form-inline form-group mb-2" style="width:100%;">
                      <input type="text" style="margin-right:0.25em" class="form-control col-lg-8" placeholder="March 4, 2018" id="inputDefault" style="width:100%;"> 
                      <input type="text" class="form-control col-lg-3" placeholder="12:00 pm" id="inputDefault" style="width:100%;">
                    </div>
                  </label>


                  <br>
                  <label class="col-form-label" for="inputDefault">
                    <b>Community visibility</b>
                    <br>
                    <div class="form-group">
                      <select name="visibility" class="form-control" id="inputDefault">
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
                    <label class="col-form-label" for="inputDefault">
                      <b>Location</b>
                    </label>
                    <input type="text" class="form-control" placeholder="Example: Casa da Música, Porto, Portugal" id="inputDefault" maxlength="60">
                  </div>

                  <div class="form-group">
                    <label class="col-form-label" for="inputDefault">
                      <b>Lodging link</b>
                    </label>
                    <input type="text" class="form-control" placeholder="Enter lodging link" id="inputDefault">
                  </div>

                  <div class="form-group">
                    <label class="col-form-label" for="inputDefault">
                      <b>Venue Information</b>
                    </label>
                    <input type="text" class="form-control" placeholder="Venue information" id="inputDefault" maxlength="100">
                  </div>
                  @include('partials.uploadImage')
                  <br>
                </fieldset>

              </div>

          </div>

        </div>

      </div>
       <button type="submit" onclick="event.preventDefault();" href="{{ route('createCommunity') }}" class="btn btn-primary d-block ml-auto mt-3">Edit</button>
      </form>
    </div>
@endsection