<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <a class="navbar-brand" href="/">
        <img src="{{asset('icon/logo.png')}}">
        <b> ReEvent</b>
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01"
            aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarColor01">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="/">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href ="" {{--route('events/top')--}} >Events</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="" {{--route('communities/top')--}} >Communities</a>
            </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
            <div class="search">
                <span class="fa fa-search"></span>
                <input placeholder="Search..." style="border-radius: 5px; height: 35px; margin-right: 5px;">
            </div>
            <button type="button" onclick="location.href='{{route('login')}}';" class="btn btn-success" style="border-radius: 5px; height: 35px;">Login</button>
        </form>
    </div>
</nav>