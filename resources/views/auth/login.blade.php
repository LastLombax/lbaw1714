@extends('layout')

@section('content')
{{--<form method="POST" action="{{ route('login') }}">--}}
    {{--{{ csrf_field() }}--}}

    {{--<label for="email">E-mail</label>--}}
    {{--<input id="email" type="email" name="email" value="{{ old('email') }}" required autofocus>--}}
    {{--@if ($errors->has('email'))--}}
        {{--<span class="error">--}}
          {{--{{ $errors->first('email') }}--}}
        {{--</span>--}}
    {{--@endif--}}

    {{--<label for="password" >Password</label>--}}
    {{--<input id="password" type="password" name="password" required>--}}
    {{--@if ($errors->has('password'))--}}
        {{--<span class="error">--}}
            {{--{{ $errors->first('password') }}--}}
        {{--</span>--}}
    {{--@endif--}}

    {{--<label>--}}
        {{--<input type="checkbox" name="remember" {{ old('remember') ? 'checked' : '' }}> Remember Me--}}
    {{--</label>--}}

    {{--<button type="submit">--}}
        {{--Login--}}
    {{--</button>--}}
    {{--<a class="button button-outline" href="{{ route('register') }}">Register</a>--}}
{{--</form>--}}


<form method="POST" action="{{ route('login') }}" style="background-color: #eee; padding: 20px; padding-top: 10px; border-radius: 10px; border: 1px solid #ccc;">
    {{ csrf_field() }}
    <fieldset>
        <br>
        <div style="text-align: center;"><img src="icon/account.png" alt="god" style=" object-fit: cover; border: 1px solid #ccc; width: 200px; border-radius: 200px; padding-bottom: 10px;"></div>
        <br>
        <div class="form-group">
            <label class="col-form-label" for="username">Username</label>
            <input id="username"  name="username" type="text" class="form-control" placeholder="Enter Username"  style="border-radius: 7px; padding: 12px;">
        </div>
        <div class="form-group">
            <label class="col-form-label" for="password">Password</label>
            <input id="password" type="password" class="form-control"  placeholder="Password" style="border-radius: 7px; padding: 12px;">
        </div>
    </fieldset>
    <button type="submit" class="btn btn-success" style="border-radius: 0px; width: 75px; padding: 12px; background-color: #158cb8"><b>Login</b></button>

    <button type="submit" onclick="event.preventDefault(); location.href = '/';" class="btn btn-success" style="border-radius: 0px; width: 75px; padding: 12px; background-color: #898888"><b>Back</b></button>
</form>
@endsection
