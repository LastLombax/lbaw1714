@extends('layout')

@section('title')
   Editing {{$member->name}}'s profile | ReEvent
@endsection

@section('titleIcon')
    <i class="fas fa-user"></i>
@endsection

@section('pageTitle')
   Editing <b>{{$member->name}}'s</b> profile
@endsection

@section('content')
<div class="container">
    <div class="bs-docs-section">
        <div class="row">

            <div class="col-lg-6" style="padding-top: 23px;">

                <div class="col-lg-12" style="padding-left: 0; padding-right:0;">
                    <div class="bs-ccomponent">

                        <div style="background-color: #eee; padding: 20px; padding-top: 10px;">
                            <fieldset>
                                <h3>Personal details</h3>
                                <div class="form-group">
                                    <label class="col-form-label" for="form_name">
                                        <b>Name</b>
                                    </label>
                                <input class="form-control" placeholder="Name" id="form_name" maxlength="100" type="text" value="{{$member->name}}">
                                </div>

                                <div class="form-group">
                                    <label class="col-form-label" for="form_dob">
                                        <b>Date of birth</b>
                                    </label>
                                    <input class="form-control" placeholder="Date of birth" id="form_dob" type="date" value="{{$member->birthdate}}">
                                </div>

                                <div class="form-group">
                                    <label class="col-form-label" for="form_address">
                                        <b>Address</b>
                                    </label>
                                    <input style="margin-bottom:0.5rem;" class="form-control" placeholder="Address line 1" id="form_address" maxlength="300" type="text" value="{{$member->address}}">
                                    <input class="form-control" placeholder="Address line 2" id="form_address" maxlength="300" type="text">
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your Address with anyone else.</small>
                                </div>

                                <div class="form-group">
                                    <label class="col-form-label" for="form_country">
                                        <b>Country</b>
                                    </label>
                                    @include('layouts.countrySelector')
                                </div>

                                <br>
                                <button type="submit" onclick="event.preventDefault(); location.href = 'createEvent2.html';" class="btn btn-primary">Save changes</button>
                            </fieldset>

                        </div>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6" style="padding-top: 23px;">

                <div class="col-lg-12" style="padding-left: 0; padding-right:0;">
                    <div class="bs-ccomponent">

                        <div style="background-color: #eee; padding: 20px; padding-top: 10px;">
                            <h3>Account details</h3>
                            <fieldset style=" margin-bottom:1.140em;">
                                <div class="form-group">
                                    <label class="col-form-label" for="eventImg">
                                        <b>About</b>
                                    </label>
                                <textarea class="form-control-file" id="memberDescri">{{$member->about}}</textarea>
                                </div>

                                <div class="form-group">
                                    <label class="col-form-label" for="form_email">
                                        <b>E-mail address</b>
                                    </label>
                                    <input class="form-control" placeholder="Enter e-mail address" id="form_email" maxlength="50" type="text" value="{{$member->email}}">
                                </div>

                                <div class="form-group">
                                    <label class="col-form-label" for="form_newpassword">
                                        <b>Password</b>
                                    </label>
                                    <input class="form-control" placeholder="New Password" id="form_newpassword" maxlength="25" type="password">
                                </div>

                                <div class="form-group">
                                    <label class="col-form-label" for="form_confirm">
                                        <b>Confirm Password</b>
                                    </label>
                                    <input class="form-control" placeholder="Confirm New Password" id="form_confirm" maxlength="25" type="password">
                                </div>

                                <div class="form-group">
                                    <label class="col-form-label" for="eventImg">
                                        <b>Image input</b>
                                    </label>
                                    <input class="form-control-file" id="eventImg" aria-describedby="fileHelp" type="file">
                                </div>

                            </fieldset>
                            <button type="submit" onclick="event.preventDefault(); location.href = 'createEvent2.html';" class="btn btn-primary ">Save changes</button>

                        </div>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <br>
    </div>
</div>
@endsection