<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
    @section('title')
        ReEvent
    @endsection
    @include('layouts.visitorHead')
</head>
<body>
@include('layouts.visitorNav')
    <div class="content">
        <div class="row" style="margin: 0; width:100%;">


            <div class="col-lg-8">
                <iframe style="border: none; width: 100%; margin-right: 15px; min-height: 500px; height: 100%" src="/slide" seamless></iframe>
            </div>

            <br>
            <br>

            <div class="col-lg-4">
                <div class="jumbotron" style="padding: 30px; width: 100%; height: 100%">
                    <h1 style="font-size: 3em;">Welcome, Visitor.</h1>
                    <p class="lead" style="font-size: 1.5em;">This is a simple mockup for our website that will never ever have all the components we said it would. But we will try
                        our best!</p>
                    <hr class="my-4" style="font-size: 1.5em;">
                    <p>We know you are a visitor, a new guy in our complex plataform, so, don't think twice and join us!</p>
                    <p class="lead">
                        <a class="btn btn-primary btn-lg" href="register" role="button">Register</a>
                    </p>
                </div>
            </div>
        </div>


        <br>
        <br>
        <div class="container" style="padding-bottom: -30px;">
            <div class="row justify-content-center align-items-center">

                <div class="col-lg-4 align-self-start">
                    <div class="bs-ccomponent">
                        <div class="card mb-3">
                            <h3 class="card-header" style="border-bottom: 10px solid #158cb8">Upcoming Events</h3>
                            @include('pages.events.upcomingEventFragment')
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 align-self-start">
                    <div class="bs-ccomponent">
                        <div class="card mb-3">
                            <h3 class="card-header" style="border-bottom: 10px solid #158cb8">Nearby Events</h3>
                            <div class="card-body">
                                <h5 class="card-title" style="font-size: 1.2em">SuperBock Super Rock</h5>
                                <h6 class="card-subtitle text-muted">20th July, 2018</h6>
                            </div>
                            <img style="width: 100%; height: 200px; object-fit: cover;" src="img/superbock.png" alt="Card image">
                            <div class="card-body">
                                <p class="card-text">O Super Bock Super Rock é um festival de música de Verão realizado anualmente em Portugal. É organizado desde 1995
                                    e é, actualmente, um dos mais importantes festivais portugueses.</p>
                            </div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item" style="font-size: 1.2em">Nos Alive</li>
                                <li class="list-group-item" style="font-size: 1.2em">Rock in Rio</li>
                                <li class="list-group-item" style="font-size: 1.2em">Queima das Fitas Porto</li>
                            </ul>
                            <div class="card-footer text-muted">
                                <a href="#" class="card-link">More Events</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 align-self-start">
                    <div class="bs-ccomponent">
                        <div class="card mb-3">
                            <h3 class="card-header" style="border-bottom: 10px solid #f36833">Top Communities</h3>
                            <div class="card-body">
                                <h5 class="card-title" style="font-size: 1.2em">Feupinhos</h5>
                                <h6 class="card-subtitle text-muted">521 members</h6>
                            </div>
                            <img style="width: 100%; height: 200px; object-fit: cover;" src="img/caloiros.jpg" alt="Card image">
                            <div class="card-body">
                                <p class="card-text">O grupo dos feupinhos é um grupo publico da comunidade de caloiros da Faculdade de Engenharia da Universidade do
                                    Porto. Este é o local em que todos os "noobs" devem estar.</p>
                            </div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item" style="font-size: 1.2em">Desajeitados</li>
                                <li class="list-group-item" style="font-size: 1.2em">Os Lambe Botas</li>
                                <li class="list-group-item" style="font-size: 1.2em">Primeiros dos ultimos</li>
                            </ul>
                            <div class="card-footer text-muted">
                                <a href="#" class="card-link" style="color: #f36833;">More Communities</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col">
                    <br>
                    <div class="jumbotron" style="padding: 25px">
                        <h1 class="display-5">Questions?</h1>
                        <p class="lead">Need help? This is just a bit of what our platform has to offer. You can see events, join them, buy tickets, be part
                            of a community and much more. Besides this you might need more help to understand all about! Consult our FAQ pages.</p>
                        <p class="lead">
                            <a class="btn btn-primary btn-lg" href="{{route('faq')}}" role="button">Take me there</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    @include('layouts.footer')
</body>
</html>