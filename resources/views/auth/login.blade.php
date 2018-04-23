<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
    @section('title')
        ReEvent
    @endsection
    @include('layouts.visitorHead')
</head>
    <body>
    <div class="container" style="width: 100%; max-width: 400px; margin: auto; padding-top: 23px;">

        <nav class="navbar navbar-expand-lg navbar-dark bg-primary" style="margin: 0 auto; width: 200px; border-top-left-radius: 10px; border-top-right-radius: 10px;">
            <a class="navbar-brand" href="/" style="margin: 0 auto;"><img src="icon/logo.png"> ReEvent</a>
        </nav>

        <br>
            <form method="POST" action="{{ route('login') }}" style="margin-top:-22px; background-color: #eee; padding: 20px; padding-top: 10px; border-radius: 10px; border: 1px solid #ccc;">
                {{ csrf_field() }}
                <fieldset>
                    <br>
                    <div style="text-align: center;"><img src="icon/account.png" alt="god" style=" object-fit: cover; border: 1px solid #ccc; width: 200px; border-radius: 200px; padding-bottom: 10px;"></div>
                    <br>
                    <div class="form-group">
                        <label class="col-form-label" for="username">Username</label>
                        @if ($errors->has('username') || $errors->has('username'))
                            <input id="username"  name="username" type="text" class="form-control is-invalid" placeholder="Enter Username"  style="border-radius: 7px; padding: 12px;" required>
                        @else
                            <input id="username"  name="username" type="text" class="form-control" placeholder="Enter Username"  style="border-radius: 7px; padding: 12px;" required>
                        @endif
                    </div>
                    <div class="form-group">
                        <label class="col-form-label" for="password">Password</label>
                        @if ($errors->has('username') || $errors->has('username'))
                            <input id="password" name="password" type="password" class="form-control is-invalid"  placeholder="Password" style="border-radius: 7px; padding: 12px;" required>
                        @else
                            <input id="password" name="password" type="password" class="form-control"  placeholder="Password" style="border-radius: 7px; padding: 12px;" required>
                        @endif
                    </div>
                </fieldset>
                <fieldset>
                    <div class="custom-control custom-checkbox">
                        <input id="remember" name="remember" type="checkbox" class="custom-control-input">
                        <label class="custom-control-label" for="remember"> Keep me logged in</label>
                    </div>
                    <br>
                    <button type="submit" class="btn btn-success" style="border-radius: 0px; width: 75px; padding: 12px; background-color: #158cb8"><b>Login</b></button>

                    <button type="submit" onclick="event.preventDefault(); location.href = '/';" class="btn btn-success" style="border-radius: 0px; width: 75px; padding: 12px; background-color: #898888"><b>Back</b></button>
                </fieldset>
            </form>
        @include('layouts.footer')
        </div>
        <br><br><br>

    </body>
</html>