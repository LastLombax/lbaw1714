<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
    @section('title')
        Reset Password
    @endsection
    @include('layouts.visitorHead')
</head>
    <body>
 <div class="container" style=" max-width: 400px; margin: auto; padding-top: 23px;">
     <nav class="navbar navbar-expand-lg navbar-dark bg-primary" style="margin: 0 auto; width: 200px; border-top-left-radius: 10px; border-top-right-radius: 10px;">
    <a class="navbar-brand" href="/" style="margin: 0 auto;"><img src="/icon/logo.png"> ReEvent</a>
</nav>    
<br>
    <form class="form-horizontal" method="POST" action="{{ route('password.request') }}" style="margin-top:-22px; background-color: #eee; padding: 20px; padding-top: 10px; border-radius: 10px; border: 1px solid #ccc;">
    {{ csrf_field() }}
 <fieldset>
    <h3>Reset Password</h3>
    <input type="hidden" name="token" value="{{ $token }}">

    <div style="width: 150%;" class="form-group{{ $errors->has('email') ? ' has-error' : '' }}">
        <label for="email" class="col-md-4 control-label">E-Mail Address</label>

        <div class="col-md-6" >
            <input id="email" type="email" class="form-control" name="email" value="{{ $email or old('email') }}" required autofocus>

            @if ($errors->has('email'))
                <span class="help-block">
                    <strong>{{ $errors->first('email') }}</strong>
                </span>
            @endif
        </div>
    </div>
    <div  style="width: 150%;" class="form-group{{ $errors->has('password') ? ' has-error' : '' }}">
        <label for="password" class="col-md-4 control-label">Password</label>

        <div class="col-md-6">
            <input id="password" type="password" class="form-control" name="password" required>

            @if ($errors->has('password'))
                <span class="help-block">
                    <strong>{{ $errors->first('password') }}</strong>
                </span>
            @endif
        </div>
    </div>

    <div  style="width: 150%;" class="form-group{{ $errors->has('password_confirmation') ? ' has-error' : '' }}">
        <label for="password-confirm" class="col-md-4 control-label">Confirm Password</label>
        <div class="col-md-6">
            <input id="password-confirm" type="password" class="form-control" name="password_confirmation" required>

            @if ($errors->has('password_confirmation'))
                <span class="help-block">
                    <strong>{{ $errors->first('password_confirmation') }}</strong>
                </span>
            @endif
        </div>
    </div>

</fieldset>
    <div class="form-group">
        <div class="col-md-6 col-md-offset-4">
            <button type="submit" class="btn btn-primary">
                Reset Password
            </button>
        </div>
    </div>
</form>
                

  </body>
</html>
