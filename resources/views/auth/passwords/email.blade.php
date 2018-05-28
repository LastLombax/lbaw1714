<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
    <head>
        @section('title')
            Reset Password | ReEvent
        @endsection
        @include('layouts.visitorHead')
    </head>
    <body>
    <div class="container" style="width: 100%; max-width: 400px; margin: auto; padding-top: 23px;">

        <nav class="navbar navbar-expand-lg navbar-dark bg-primary" style="margin: 0 auto; width: 200px; border-top-left-radius: 10px; border-top-right-radius: 10px;">
            <a class="navbar-brand" href="/" style="margin: 0 auto;"><img src="/icon/logo.png"> ReEvent</a>
        </nav>

        <br>
            <form method="POST" action="{{ route('password.email') }}" style="margin-top:-22px; background-color: #eee; padding: 20px; padding-top: 10px; border-radius: 10px; border: 1px solid #ccc;">
                {{ csrf_field() }}
                <fieldset>
                    <h3>Reset Password</h3>
                    <div class="form-group{{ $errors->has('email') ? ' has-error' : '' }}" style="width:150%">
                        <label for="email" class="col-form-label">E-Mail Address</label>
                        <div class="col-md-6">
                            <input id="email" type="email" class="form-control" name="email" value="{{ old('email') }}" required>
                            @if ($errors->has('email'))
                                <span class="help-block"><strong>{{ $errors->first('email') }}</strong></span>
                            @endif
                        </div>
                    </div>
                </fieldset>
                <div class="form-group">
                    <div class="col-md-6 col-md-offset-4">
                        <button type="submit" class="btn btn-primary">
                            Send Password Reset Link
                        </button>
                    </div>
                </div>
            </form>
            @include('layouts.footer')
        </div>
    </body>
</html>