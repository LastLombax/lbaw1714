@extends('layout')

@section('content')
<div class="container" style="width: 100%; max-width: 33em;">
<form method="POST" action="{{ route('login') }}" style="background-color: #eee; padding: 20px; padding-top: 10px; border-radius: 10px; border: 1px solid #ccc;">
    {{ csrf_field() }}
    <fieldset>
        <br>
        <div style="text-align: center;"><img src="icon/account.png" alt="god" style=" object-fit: cover; border: 1px solid #ccc; width: 200px; border-radius: 200px; padding-bottom: 10px;"></div>
        <br>
        <div class="form-group">
            <label class="col-form-label" for="username">Username</label>
            <input id="username"  name="username" type="text" class="form-control" placeholder="Enter Username"  style="border-radius: 7px; padding: 12px;" required>
        </div>
        <div class="form-group">
            <label class="col-form-label" for="password">Password</label>
            <input id="password" type="password" class="form-control"  placeholder="Password" style="border-radius: 7px; padding: 12px;" required>
        </div>
    </fieldset>
    <button type="submit" class="btn btn-success" style="border-radius: 0px; width: 75px; padding: 12px; background-color: #158cb8"><b>Login</b></button>

    <button type="submit" onclick="event.preventDefault(); location.href = '/';" class="btn btn-success" style="border-radius: 0px; width: 75px; padding: 12px; background-color: #898888"><b>Back</b></button>
</form>
</div>
@endsection
