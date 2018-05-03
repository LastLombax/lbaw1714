<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <a class="navbar-brand" href="/">
        <img src="{{asset('icon/logo.png')}}">
        <b> ReEvent</b>
    </a>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01"
            aria-controls="navbarColor01"
            aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarColor01">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="/">Home
                    <span class="sr-only">(current)</span>
                </a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="" role="button" aria-haspopup="true"
                   aria-expanded="false">Events</a>
                <div class="dropdown-menu" x-placement="bottom-start">
                    <a class="dropdown-item" href="{{route('createEvent')}}"><i class="fas fa-plus"></i> Add Event</a>
                    <a class="dropdown-item" href="{{route('manageEvents')}}"><i class="fas fa-edit"></i> Manage your
                        Events</a>
                    <a class="dropdown-item" href="{{route('events')}}"><i class="fas fa-search"></i> Search for Events</a>
                </div>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true"
                   aria-expanded="false">Communities</a>
                <div class="dropdown-menu" x-placement="bottom-start">
                    <a class="dropdown-item" href="{{route('createCommunity')}}"><i class="fas fa-plus"></i> Add
                        Community</a>
                    <a class="dropdown-item" href="{{route('manageCommunities')}}"><i class="fas fa-edit"></i> Manage
                        your Communities</a>
                    <a class="dropdown-item" href="{{route('communities')}}"><i class="fas fa-search"></i> Search for
                        Communities</a>
                </div>
            </li>
            <li class="nav-item dropdown" id="profileText">
                <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true"
                   aria-expanded="false"> My Account</a>
                <div class="dropdown-menu" x-placement="bottom-start">
                    <a class="dropdown-item" href="/members/{{Auth::user()->username}}"><i class="fas fa-user"></i> My Profile</a>
                    <a class="dropdown-item" href="myFriends.html"><i class="fas fa-users"></i> My Friends</a>
                    <a class="dropdown-item" href="{{ url('/logout') }}"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="administration.html">Administration</a>
            </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
        <!--<table style="font-size: 12px; color: white; text-align: right; margin-right: 15px;">
                <tr style="font-size: 9.5px">
                    <td>
                        @if (Auth::check())
            Welcome, <span>{{ Auth::user()->name }}</span>
                        @endif
                </td>
            </tr>
            <tr>
                <td style="padding-left: 5px; padding-right: 5px; border: 1px solid white;"><i class="fas fa-plus"></i>
               <a href="{{route('createEvent')}}" style="text-decoration: none; color: white;"> <b>Add Event</b> </a>
                    </td>
                </tr>
            </table>-->
            @if (Auth::check())
                <div class="nav-item dropdown" id="profileIcon">
                    <i class="material-icons"
                       style="font-size: 32px; color: rgba(255, 255, 255, 1); cursor: pointer;" data-toggle="dropdown"
                       href="#" role="button" aria-haspopup="true" aria-expanded="false">account_circle</i>

                    <div class="dropdown-menu" x-placement="bottom-start"
                         style="position: flex; transform: translate3d(-85px, 42px, 0px); top: 0px; left: 0px; will-change: transform;">

                        <a class="dropdown-item" href="/members/{{Auth::user()->username}}"><i class="fas fa-user"></i> My
                            Profile</a>
                        <a class="dropdown-item" href="myFriends.html"><i class="fas fa-users"></i> My Friends</a>
                        <a class="dropdown-item" href="{{ url('/logout') }}"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </div>
                </div>
            @endif
        </form>
    </div>
</nav>