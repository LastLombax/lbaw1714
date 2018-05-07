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
     <form action="{{ route('editForm', ['member' => $member])}}" method="POST" enctype="multipart/form-data">
       {{ method_field('PATCH') }}
       {{ csrf_field() }}

        <div class="row">
          
            <div class="col-lg-6" style="padding-top: 23px;">

                <div class="col-lg-12" style="padding-left: 0; padding-right:0;">
                    <div class="bs-ccomponent">

                        <div style="background-color: #eee; padding: 20px; padding-top: 10px;">
                            <fieldset>
                                <h3>Personal details</h3>
                                <div class="form-group">
                                    <label class="col-form-label" for="name">
                                        <b>Name</b>
                                    </label>
                                <input id="name" name="name" class="form-control" placeholder="Name" maxlength="100" type="text" value="{{$member->name}}">
                                </div>

                                <div class="form-group">
                                    <label class="col-form-label" for="birthdate">
                                        <b>Date of Birth</b>
                                    </label>
                                    <input id="birthdate" name="birthdate" class="form-control" placeholder="Date of birth" type="date" value="{{$member->birthdate}}">
                                </div>

                                <div class="form-group">
                                    <label class="col-form-label" for="address">
                                        <b>Address</b>
                                    </label>
                                    <textarea id="address" name="address" class="form-control-file" maxlength="300">{{$member->address}}</textarea>                    
                                    <small id="addressHelp" class="form-text text-muted">We'll never share your Address with anyone else.</small>
                                </div>

                                <div class="form-group">
                                    <select id="country" name="country" class="form-control" required>
                                        <option value="">Choose</option>
                                        @foreach(App\Country::all() as $country)
                                            @if($member->idcountry == $country->idcountry)
                                                <option value="{{$country->name}}" selected>{{$country->name}}</option>
                                            @else
                                                <option value="{{$country->name}}">{{$country->name}}</option>
                                            @endif
                                        @endforeach
                                    </select>
                                </div>
                                  
                                <br>
                                <button type="submit" class="btn btn-primary">Save changes</button>
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
                                    <label class="col-form-label" for="about">
                                        <b>About</b>
                                    </label>
                                    
                                <textarea id="about" name="about" class="form-control-file">{{$member->about}}</textarea>
                                </div>

                                <div class="form-group">
                                    <label class="col-form-label" for="email">
                                        <b>E-mail address</b>
                                    </label>
                                    <input id="email" name="email" class="form-control" placeholder="Enter e-mail address" maxlength="50" type="text" value="{{$member->email}}">
                                </div>

                                <div class="form-group">
                                    <label class="col-form-label" for="password">
                                        <b>Password</b>
                                    </label>
                                    <input id="password" name="password" class="form-control" placeholder="New Password" id="form_newpassword" maxlength="25" type="password">
                                </div>

                                <div class="form-group">
                                    <label id="password_confirmation" name="password_confirmation" class="col-form-label" for="form_confirm">
                                        <b>Confirm Password</b>
                                    </label>
                                    <input id="password_confirmation" name="password_confirmation" class="form-control" placeholder="Confirm New Password" id="form_confirm" maxlength="25" type="password">
                                </div>

                                @include('partials.uploadImage')

                            </fieldset>
                            <button type="submit" class="btn btn-primary ">Save changes</button>

                        </div>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                </div>
              </div>

            </div>
           </form>
        <br>
    </div>
</div>
@endsection