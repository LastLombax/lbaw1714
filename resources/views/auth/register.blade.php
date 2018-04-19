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
            <a class="navbar-brand" href="index.html" style="margin: 0 auto;"><img src="icon/logo.png"> ReEvent</a>
        </nav>

        <br>

            <form method="POST" action="{{ route('register') }}" style="margin-top:-22px; background-color: #eee; padding: 20px; padding-top: 10px; border-radius: 10px; border: 1px solid #ccc;">
                {{ csrf_field() }}
                <fieldset>
                    <div class="form-group">
                        <label class="col-form-label" for="username">Username</label>

                        @if (!$errors->has('username'))
                            <input id="username" name="username"  type="text" value="{{ old('username') }}" class="form-control" placeholder="Enter username" required>
                        @else
                            <input id="username" name="username"  type="text" value="{{ old('username') }}" class="form-control is-invalid" placeholder="Enter username" required>
                        @endif

                    </div>

                    <div class="form-group">
                        <label class="col-form-label" for="username">Name</label>
                        <input id="name" name="name"  type="text" value="{{ old('name') }}" class="form-control" placeholder="Enter your name" required>
                    </div>

                    <div class="form-group">
                    <label for="email">Email address</label>

                        @if (!$errors->has('email'))
                            <input  id="email" name="email" type="email" value="{{ old('email') }}" class="form-control"  aria-describedby="emailHelp" placeholder="Enter email" required>
                        @else
                            <input  id="email" name="email" type="email" value="{{ old('email') }}" class="form-control is-invalid"  aria-describedby="emailHelp" placeholder="Enter email" required>
                        @endif

                        <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input id="password" name="password" type="password" class="form-control" placeholder="Password" required>
                    </div>

                    <div class="form-group">
                        <label for="password_confirmation">Confirm Password</label>
                        <input id="password_confirmation" name="password_confirmation" type="password" class="form-control" placeholder="Confirm Password" required>
                    </div>

                    @include('layouts.countrySelector')

                </fieldset>
                <table>
                    <tr>
                        <td>
                            <button type="submit" onclick="event.preventDefault(); location.href = '/';" class="btn btn-success" style="background-color: #898888;">Back</button>
                        </td>
                        <td>
                            <button type="submit" class="btn btn-primary">Register</button>
                        </td>
                    </tr>
                </table>

            </form>
            @include('layouts.footer')
        </div>
    </body>
</html>
