<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>ReEvent</title>

    <link rel="shortcut icon" type="image/png" href="{{ asset('icon/favicon.png')}}"/>



    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>


    <!-- Bootstrap 4.1.0-->
    {{--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">--}}
    {{--<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>--}}
    <link href="{{ asset('css/bootstrap.min.css')}}" rel="stylesheet">
    <script src="{{ asset('js/bootstrap.min.js')}}"></script>

    <!-- FontAwesome -->
    <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
    <!-- GoogleImports -->
    <link href="https://fonts.googleapis.com/css?family=Salsa" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    {{--Slideshow && Navbar --}}

    <script type="text/javascript" src="js/searchNavBar.js"></script>
    <link href="{{ asset('css/timeline.css')}}" rel="stylesheet">
    <link href="{{ asset('css/searchBar.css')}}" rel="stylesheet">

    <script type="text/javascript">
        // Fix for Firefox autofocus CSS bug
        // See: http://stackoverflow.com/questions/18943276/html-5-autofocus-messes-up-css-loading/18945951#18945951
    </script>

</head>
<body style="width: 100%">

@include('layouts.nav')

{{--@include('layouts.newSearchBar')--}}
{{--<div style="border: none; border-bottom: 1px solid #ccc; width: 100%; height: 100px;">--}}

{{--</div>--}}

<div class="container">
    <legend style="color: #333; padding: 1rem; margin-left: 0.5rem; padding-left: 0; padding-bottom: 0;">
        @yield('titleIcon')
        <span style="margin-left: .5rem;">
                @yield('pageTitle')
        </span>
    </legend>

    <div class="bs-docs-section" style="margin-left: .5rem; margin-right: .5rem; padding-top: 1rem; "{{--style="padding-bottom: -1em;"--}}>

        <section id="content">
            @yield('content')
        </section>
    </div>

    @include('layouts.footer')
</div>
</body>
</html>
