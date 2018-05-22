@extends('layout')

@section('titleIcon')
    <i class="fas fa-calendar-check"></i>
@endsection

@section('pageTitle')
    Creating an Event
@endsection


@section('content')

    <form method="POST" action="{{ route('createEvent') }}" enctype="multipart/form-data">
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
                                @if ($errors->has('name'))
                                <input id="name" name="name" required type="text" style="width:100%;"
                                       class="form-control col-xs-3 is-invalid" placeholder="Enter event name" maxlength="80">
                                <div class="alert alert-dismissible alert-danger">
                                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                                <strong>Error: </strong>{{$errors->first('name')}}
                                </div>                                  
                                @else
                               <input id="name" name="name" required type="text" style="width:100%;"
                               class="form-control col-xs-3" placeholder="Enter event name" maxlength="80">
                               @endif
                            </div>
                            <div class="form-group">
                                <label class="col-form-label" for="description" style="width:100%;">
                                    <b>Description</b>
                                </label>
                                @if ($errors->has('description'))
                                    <div class="form-inline form-group mb-2" style="width:100%;">
                                        <textarea id="description" name="description" required class="form-control is-invalid"
                                                  placeholder="Description" maxlength="255"
                                                  style="width:100%;"> </textarea>
                                    </div>
                                    <div class="alert alert-dismissible alert-danger">
                                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                                    <strong>Error: </strong>{{$errors->first('description')}}
                                    </div>
                                @else
                                <div class="form-inline form-group mb-2" style="width:100%;">
                                    <textarea id="description" name="description" required class="form-control"
                                             placeholder="Description" maxlength="255"
                                             style="width:100%;"> </textarea>
                                </div>
                                @endif
                            </div>
                            <div class="form-group">
                                <label class="col-form-label" for="startDate" style="width:100%;">
                                    <b>Start date</b>
                                </label>
                                <div class="form-inline form-group mb-2" style="width:100%;">

                                @if ($errors->has('startDate'))
                                    <input id="startDate" name="startDate" required type="date"
                                           style="margin-right:0.25em" class="form-control col-lg-8"
                                           placeholder="March 4, 2018" style="width:100%;">                                  
                                     <div class="alert alert-dismissible alert-danger">
                                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                                    <strong>Error: </strong>{{$errors->first('startDate')}}
                                    </div>

                                @else
                                    <input id="startDate" name="startDate" required type="date"
                                           style="margin-right:0.25em" class="form-control col-lg-8"
                                           placeholder="March 4, 2018" style="width:100%;">                                  
                                @endif

                                 @if ($errors->has('startTime'))
                                     <input id="startTime" name="startTime" required type="time"
                                           class="form-control col-lg-3 is-invalid" placeholder="12:00 pm" style="width:100%;">                                
                                     <div class="alert alert-dismissible alert-danger">
                                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                                    <strong>Error: </strong>{{$errors->first('startTime')}}
                                    </div>
                                @else
                                        <input id="startTime" name="startTime" required type="time"
                                        class="form-control col-lg-3" placeholder="12:00 pm" style="width:100%;">                         
                                @endif
                              </div>

                            </div>
                            <div class="form-group">
                            <label class="col-form-label" for="endDate" style="width:100%;">
                                <b>End date</b>
                                </label>
                                <div class="form-inline form-group mb-2" style="width:100%;">

                                    @if ($errors->has('endDate'))
                                        <input id="endDate" name="endDate" required type="date"
                                               style="margin-right:0.25em" class="form-control col-lg-8"
                                               placeholder="March 4, 2018" style="width:100%;">                                  
                                         <div class="alert alert-dismissible alert-danger">
                                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                                        <strong>Error: </strong>{{$errors->first('endDate')}}
                                        </div>

                                    @else
                                        <input id="endDate" name="endDate" required type="date"
                                               style="margin-right:0.25em" class="form-control col-lg-8"
                                               placeholder="March 4, 2018" style="width:100%;">                                  
                                    @endif

                                    @if ($errors->has('endTime'))
                                         <input id="endTime" name="endTime" required type="time"
                                               class="form-control col-lg-3 is-invalid" placeholder="12:00 pm" style="width:100%;">                                
                                         <div class="alert alert-dismissible alert-danger">
                                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                                        <strong>Error: </strong>{{$errors->first('endTime')}}
                                        </div>
                                    @else
                                        <input id="endTime" name="endTime" required type="time"
                                        class="form-control col-lg-3" placeholder="12:00 pm" style="width:100%;"> 
                                    @endif
                              </div>
                            </div>

                            <div class="form-group">
                               <label class="col-form-label" for="country" style="width:100%;">
                                   <b>Country</b>
                                     <div class="form-inline form-group mb-2" style="width:100%;">
                                       @include('layouts.countrySelector')
                                   </div>
                                </label>
                           </div>
                            <div class="form-group">
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
                          </div>
                        </fieldset>
                    </div>

                </div>
            </div>

            <div class="col-xl-4 align-self-start" style="padding-top: 25px;">
                <div class="bs-ccomponent">

                    <div style="background-color: #eee; padding: 20px; padding-top: 10px; border: 1px solid #ccc; box-shadow: 1px 1px 30px #ddd;">
                        <fieldset>
                            <div class="form-group">
                                <label class="col-form-label" for="address">
                                    <b>Location</b>
                                </label>                                 
                                @if ($errors->has('address'))
                                 <input id="address" name="address" type="text" class="form-control is-invalid"
                                       placeholder="Example: Casa da Música, Porto, Portugal" maxlength="60"
                                       required>
                                  <div class="alert alert-dismissible alert-danger">
                                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                                    <strong>Error: </strong>{{$errors->first('address')}}
                                  </div>
                                @else
                                 <input id="address" name="address" type="text" class="form-control"
                                       placeholder="Example: Casa da Música, Porto, Portugal" maxlength="60"
                                       required>
                                @endif
                               
                            </div>

                            <div class="form-group">
                                <label class="col-form-label" for="city">
                                    <b>City</b>
                                </label>
                                @if ($errors->has('city'))
                                <input id="city" name="city" type="text" class="form-control is-invalid"
                                       placeholder="Example: Funchal, Lisboa, Porto" maxlength="50" required>
                                <div class="alert alert-dismissible alert-danger">
                                   <button type="button" class="close" data-dismiss="alert">&times;</button>
                                   <strong>Error: </strong>{{$errors->first('address')}}
                                </div>
                                @else
                                <input id="city" name="city" type="text" class="form-control"
                                       placeholder="Example: Funchal, Lisboa, Porto" maxlength="50" required>
                                @endif
                            </div>

                            <div class="form-group">
                                <label class="col-form-label" for="lodging">
                                    <b>Lodging link</b>
                                </label>
                                <input id="lodging" name="lodging" type="text" class="form-control"
                                       placeholder="Enter lodging link" required>
                            </div>

                        </fieldset>
                    </div>
                </div>
            </div>
            @include('partials.uploadImage')
        </div>
        <button type="submit" style="box-shadow: 1px 1px 30px #ddd;"
                class="btn btn-primary d-block ml-auto mt-3">Create
        </button>
    </form>

@endsection