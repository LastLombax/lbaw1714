<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>ReEvent</title>

    <link rel="shortcut icon" type="image/png" href="{{ asset('icon/favicon.png')}}" />



    {{--<!-- Bootstrap -->--}}
    {{--<link href="css/bootstrap.min.css" rel="stylesheet">--}}
    {{--<script src="js/bootstrap.min.js"></script>--}}

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>


    <!-- Bootstrap -->
    <link href="{{ asset('css/bootstrap.min.css')}}" rel="stylesheet">
    <script src="{{ asset('js/bootstrap.min.js')}}"></script>
    <!-- FontAwesome -->
    <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
    <!-- GoogleImports -->
    <link href="https://fonts.googleapis.com/css?family=Salsa" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    {{--Slideshow && Navbar --}}

    {{--<link href="css/searchNavBar.css" rel="stylesheet">--}}
    <script type="text/javascript" src="js/searchNavBar.js"></script>
    <link href="{{ asset('css/timeline.css')}}" rel="stylesheet">

    <script type="text/javascript">
        // Fix for Firefox autofocus CSS bug
        // See: http://stackoverflow.com/questions/18943276/html-5-autofocus-messes-up-css-loading/18945951#18945951
    </script>

</head>
<body>
<!-- Yeti Template Starts Here -->
@include('layouts.nav')


<div style="border: none; border-bottom: 1px solid #ccc; width: 100%; height: 100px;">
    @include('layouts.searchNavBar')
</div>

<br>
<br>
<br>



<section id="content">
    @yield('content')
</section>

@include('layouts.footer')
</body>
</html>
