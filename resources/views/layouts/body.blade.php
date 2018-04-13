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

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <!-- Bootstrap -->
        <link href="{{ asset('css/bootstrap.min.css')}}" rel="stylesheet">
        <script src="{{ asset('js/bootstrap.min.js')}}"></script>
        <!-- FontAwesome -->
        <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
        <!-- GoogleImports -->
        <link href="https://fonts.googleapis.com/css?family=Salsa" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <link href="{{ asset('css/timeline.css')}}" rel="stylesheet">

        <script type="text/javascript">
            // Fix for Firefox autofocus CSS bug
            // See: http://stackoverflow.com/questions/18943276/html-5-autofocus-messes-up-css-loading/18945951#18945951
        </script>

    </head>
    <body>
        <!-- Yeti Template Starts Here -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <a class="navbar-brand" href="#">
                <img src="icon/logo.png">
                <b> ReEvent</b>
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarColor01">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home
                            <span class="sr-only">(current)</span>
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Events</a>
                        <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, 38px, 0px); top: 0px; left: 0px; will-change: transform;">
                            <a class="dropdown-item" href="createEvent.html" ><i class="fas fa-plus"></i> Add Event</a>
                            <a class="dropdown-item" href="manageEvents.html" ><i class="fas fa-edit"></i> Manage your Events</a>
                            <a class="dropdown-item" href="viewEvents.html" ><i class="fas fa-search"></i> Search for Events</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Communities</a>
                        <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, 38px, 0px); top: 0px; left: 0px; will-change: transform;">
                            <a class="dropdown-item" href="createCommunity.html" ><i class="fas fa-plus"></i> Add Community</a>
                            <a class="dropdown-item" href="manageCommunities.html" ><i class="fas fa-edit"></i>  Manage your Communities</a>
                            <a class="dropdown-item" href="viewCommunities.html" ><i class="fas fa-search"></i> Search for Communities</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="administration.html">Administration</a>
                    </li>
                </ul>
                <form class="form-inline my-2 my-lg-0">
                    <table style="font-size: 12px; color: white; text-align: right; margin-right: 15px;">
                        <tr style="font-size: 9.5px">
                            <td>Welcome, God</td>
                        </tr>
                        <tr>
                            <td style="padding-left: 5px; padding-right: 5px; border: 1px solid white;"><i class="fas fa-plus"></i> <b>Add Event</b></td>
                        </tr>
                    </table>
                    <i class="material-icons" style="font-size: 32px; color: rgba(255, 255, 255, 1);">account_circle</i>
                </form>
            </div>
        </nav>
        <iframe style="border: none; border-bottom: 1px solid #ccc; width: 100%; height: 100px;" src="searchNavBar.html" seamless></iframe>
        <br>
        <br>
        <br>



        <section id="content">
            @yield('content')
        </section>



        <footer id="footer " style="margin: 1em 0; padding-bottom: 2em; border-top: 1px solid #ddd; ">
            <br>
            <div class="row ">
                <div class="col-lg-12 ">

                    <table class="list-unstyled " cellpadding="7 " style="font-size: 0.9375rem; margin: 0 auto; ">
                        <tr>
                            <td class="float-lg-right ">
                                <a href="#top ">Back to top</a>
                            </td>
                            <td>
                                <a href="memberHomepage.html">Home</a>
                            </td>
                            <td>
                                <a href="about.html">About</a>
                            </td>
                            <td>
                                <a href="faq.html">FAQs</a>
                            </td>
                            <td>
                                <a href="contact.html">Contact us</a>
                            </td>
                    </table>
                    <br>
                    <div style="text-align:center; font-size: small ">
                        Template by
                        <a href="http://thomaspark.co ">Thomas Park</a>. Code released by
                        <a href="https://github.com/ ">FEUP Students</a>.
                        <br> Based on
                        <a href="https://getbootstrap.com " rel="nofollow ">Bootstrap</a>. Icons from
                        <a href="http://fontawesome.io/ " rel="nofollow ">Font Awesome</a>. Web fonts from
                        <a href="https://fonts.google.com/ " rel="nofollow ">Google</a>.
                    </div>
                </div>
            </div>
        </footer>
    </body>
</html>
