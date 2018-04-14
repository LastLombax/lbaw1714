@extends('layout')

@section('content')
    <div class="container">
        <div class="row justify-content-center align-items-center">
            <div class="col-lg-8">
                <div class="page-header">
                    <h1 id="timeline" style="font-size: 2.2em;">Upcoming Events</h1>
                </div>
                <ul class="timeline">
                    <li class="timeline-inverted">
                        <div class="timeline-badge" style="background-color: #007095; background-image: url('icon/calendar.png'); background-repeat: no-repeat; background-position: center; background-size: 22px 22px;">
                            <i class="glyphicon glyphicon-credit-card"></i>
                        </div>
                        <div class="timeline-panel ">
                            <div class="timeline-heading ">
                                <h4 class="timeline-title "><a style="text-decoration: none;" href="#">Queima das Fitas Porto</a></h4>
                                <br>
                            </div>
                            <div class="timeline-body ">
                                <div class="row ">
                                    <div class="col-lg-4 ">
                                        <img style="width: 100%; height: 150px; object-fit: cover; " src="img/queima.jpg " alt="Card image ">
                                    </div>
                                    <div class="col-lg-8 ">
                                        <p>As Noites da Queima arrancam, este ano, no dia 7 de maio, ao som de James Arthur, Virgul e David Carreira. A 8
                                            de maio, Dillaz e Dub Inc têm a missão de animar a malta, antes de, na terça-feira dia 9, o grande Quim Barreiros
                                            tome conta do palco e do espírito de todos os estudantes.
                                        </p>
                                        <div style="text-align: right; ">
                                            <h6 class="card-subtitle text-muted ">1 - 7 May, 2018</h6>
                                            <a style="text-decoration: none;" href="# ">More</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="timeline-inverted ">
                        <div class="timeline-badge" style="background-color: #007095; background-image: url( 'icon/calendar.png'); background-repeat: no-repeat;
                        background-position: center; background-size: 22px 22px; ">
                            <i class="glyphicon glyphicon-credit-card "></i>
                        </div>
                        <div class="timeline-panel ">
                            <div class="timeline-heading ">
                                <h4 class="timeline-title ">  <a style="text-decoration: none;" href="#" >Super Bock Super Rock</a></h4>
                                <br>
                            </div>
                            <div class="timeline-body ">
                                <div class="row ">
                                    <div class="col-lg-4 ">
                                        <img style="width: 100%; height: 150px; object-fit: cover; " src="img/superbock.png " alt="Card image ">
                                    </div>
                                    <div class="col-lg-8 ">
                                        <p>O Super Bock Super Rock é um festival de música de Verão realizado anualmente em Portugal. É organizado desde
                                            1995 e é, actualmente, um dos mais importantes festivais portugueses.
                                        </p>
                                        <div style="text-align: right; ">
                                            <h6 class="card-subtitle text-muted ">20th July, 2018</h6>
                                            <a style="text-decoration: none;" href="# "> More</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="timeline-inverted ">
                        <div class="timeline-badge" style="background-color: #007095; background-image: url( 'icon/calendar.png'); background-repeat: no-repeat;
                        background-position: center; background-size: 22px 22px; ">
                            <i class="glyphicon glyphicon-credit-card "></i>
                        </div>
                        <div class="timeline-panel ">
                            <div class="timeline-heading ">
                                <h4 class="timeline-title ">  <a style="text-decoration: none;" href="# ">Nos Alive</a></h4>
                                <br>
                            </div>
                            <div class="timeline-body ">
                                <div class="row ">
                                    <div class="col-lg-4 ">
                                        <img style="width: 100%; height: 150px; object-fit: cover; " src="img/nos.png " alt="Card image ">
                                    </div>
                                    <div class="col-lg-8 ">
                                        <p>NOS Alive é um festival de música anual realizado no Passeio Maritimo de Algés, em Oeiras, Portugal. É organizado
                                            pela promotora de eventos Everything Is New e patrocinado pela NOS.
                                        </p>
                                        <div style="text-align: right; ">
                                            <h6 class="card-subtitle text-muted ">12, 13, 14 July, 2018</h6>
                                            <a style="text-decoration: none;" href="# ">More</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
                <div>
                    <ul class="pagination">
                        <li class="page-item disabled ">
                            <a class="page-link " href="# ">&laquo;</a>
                        </li>
                        <li class="page-item active ">
                            <a class="page-link " href="# ">1</a>
                        </li>
                        <li class="page-item ">
                            <a class="page-link " href="# ">2</a>
                        </li>
                        <li class="page-item ">
                            <a class="page-link " href="# ">3</a>
                        </li>
                        <li class="page-item ">
                            <a class="page-link " href="# ">&raquo;</a>
                        </li>
                    </ul>
                </div>
            </div>


            <div class="col-lg-4 align-self-start">
                <div class="page-header ">
                    <h1 id="timeline " style="font-size: 2.2em; ">Management</h1>
                </div>
                <div class="bs-ccomponent " style="padding-top:20px; ">
                    <div class="card mb-3 " style="box-shadow: 1px 1px 5px #ddd; ">
                        <div class="card-body ">
                            <table style="width: 100%; ">
                                <tr>
                                    <td>
                                        <h5 class="card-title ">My Events</h5>
                                    </td>
                                    <td style="text-align: right; ">
                                        <button style="margin-bottom: 10px; background-color: white; border: 1px solid #158cb8; color: #158cb8; width: 125px;" class="btn btn-success" onclick="window.location.href= 'createEvent.html';">
                                            Event
                                            <i class="fas fa-plus"></i>
                                        </button>
                                    </td>
                                </tr>
                            </table>
                            <ul class="list-group list-group-flush ">
                                <li class="list-group-item " style="font-size: 1.2em ">
                                    <table style="width: 100%; ">
                                        <tr>
                                            <td style="font-size: 1.1em ">American Pie Party</td>
                                            <td style="text-align: right; ">
                                                <i style="font-size: 16px;" class="material-icons ">build</i>
                                            </td>
                                        </tr>
                                    </table>
                                </li>
                                <li class="list-group-item " style="font-size: 1.2em ">
                                    <table style="width: 100%; ">
                                        <tr>
                                            <td style="font-size: 1.1em ">FEUP Caffe</td>
                                            <td style="text-align: right; ">
                                                <i style="font-size: 16px;" class="material-icons ">build</i>
                                            </td>
                                        </tr>
                                    </table>
                                </li>
                                <li class="list-group-item " style="font-size: 1.2em ">
                                    <table style="width: 100%; ">
                                        <tr>
                                            <td style="font-size: 1.1em ">Coisas e Vinho Verde</td>
                                            <td style="text-align: right; ">
                                                <i style="font-size: 16px;" class="material-icons ">build</i>
                                            </td>
                                        </tr>
                                    </table>
                                </li>
                                <br>
                                <div style="text-align: right; font-size: 1.2em ">
                                    <a href="#">
                                        <b>More</b>&nbsp; &nbsp;</a>
                                </div>
                            </ul>
                        </div>
                        <div class="card-body ">
                            <table style="width: 100%; ">
                                <tr>
                                    <td>
                                        <h5 class="card-title ">My Communities</h5>
                                    </td>
                                    <td style="text-align: right; ">
                                        <button style="margin-bottom: 10px; background-color: white; border: 1px solid #f36833; color: #f36833; width: 125px;" class="btn btn-success" onclick="window.location.href= 'createCommunity.html';">
                                            Community
                                            <i class="fas fa-plus"></i>
                                        </button>
                                    </td>
                                </tr>
                            </table>
                            <ul class="list-group list-group-flush ">
                                <li class="list-group-item ">
                                    <table style="width: 100%; ">
                                        <tr>
                                            <td style="font-size: 1.1em ">American Pie Party</td>
                                            <td style="text-align: right;">
                                                <i style="font-size: 16px;" class="material-icons ">build</i>
                                            </td>
                                        </tr>
                                    </table>
                                </li>
                                <li class="list-group-item " style="font-size: 1.2em ">
                                    <table style="width: 100%; ">
                                        <tr>
                                            <td style="font-size: 1.1em ">FEUP Caffe</td>
                                            <td style="text-align: right; ">
                                                <i style="font-size: 16px;" class="material-icons ">build</i>
                                            </td>
                                        </tr>
                                    </table>
                                </li>
                                <li class="list-group-item " style="font-size: 1.2em ">
                                    <table style="width: 100%; ">
                                        <tr>
                                            <td style="font-size: 1.1em ">Coisas e Vinho Verde</td>
                                            <td style="text-align: right; ">
                                                <i style="font-size: 16px;" class="material-icons ">build</i>
                                            </td>
                                        </tr>
                                    </table>
                                </li>
                                <div style="text-align: right; font-size: 1.2em ">
                                    <a href="# " style="color: #f36833;">
                                        <b>More</b>&nbsp; &nbsp;</a>
                                </div>
                            </ul>
                        </div>
                        <div class="card-footer text-muted ">
                            <a href="administration.html" class="card-link">
                                <i class="material-icons ">settings</i> Website Admin</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <br>



    <div class="container " style="padding-bottom: -30px; ">
        <div class="row justify-content-center align-items-center">
            <div class="col-lg-4">
                <div class="bs-ccomponent ">
                    <div class="card mb-3 " style="box-shadow: 1px 1px 5px #ddd; ">
                        <h3 class="card-header " style="border-bottom: 10px solid #158cb8 ">Nearby Events</h3>
                        <div class="card-body ">
                            <h5 class="card-title " style="font-size: 1.2em ">SuperBock Super Rock</h5>
                            <h6 class="card-subtitle text-muted ">20th July, 2018</h6>
                        </div>
                        <img style="width: 100%; height: 200px; object-fit: cover; " src="img/superbock.png " alt="Card image ">
                        <div class="card-body ">
                            <p class="card-text ">O Super Bock Super Rock é um festival de música de Verão realizado anualmente em Portugal. É organizado desde 1995
                                e é, actualmente, um dos mais importantes festivais portugueses.
                            </p>
                        </div>
                        <ul class="list-group list-group-flush ">
                            <li class="list-group-item " style="font-size: 1.2em ">Nos Alive</li>
                            <li class="list-group-item " style="font-size: 1.2em ">Rock in Rio</li>
                            <li class="list-group-item " style="font-size: 1.2em ">Queima das Fitas Porto</li>
                        </ul>
                        <div class="card-footer text-muted ">
                            <a href="# " class="card-link ">More Events</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 ">
                <div class="bs-ccomponent ">
                    <div class="card mb-3 " style="box-shadow: 1px 1px 5px #ddd; ">
                        <h3 class="card-header " style="border-bottom: 10px solid #158cb8 ">Top Events</h3>
                        <div class="card-body ">
                            <h5 class="card-title " style="font-size: 1.2em ">SuperBock Super Rock</h5>
                            <h6 class="card-subtitle text-muted ">20th July, 2018</h6>
                        </div>
                        <img style="width: 100%; height: 200px; object-fit: cover; " src="img/superbock.png " alt="Card image ">
                        <div class="card-body ">
                            <p class="card-text ">O Super Bock Super Rock é um festival de música de Verão realizado anualmente em Portugal. É organizado desde 1995
                                e é, actualmente, um dos mais importantes festivais portugueses.
                            </p>
                        </div>
                        <ul class="list-group list-group-flush ">
                            <li class="list-group-item " style="font-size: 1.2em ">Nos Alive</li>
                            <li class="list-group-item " style="font-size: 1.2em ">Rock in Rio</li>
                            <li class="list-group-item " style="font-size: 1.2em ">Queima das Fitas Porto</li>
                        </ul>
                        <div class="card-footer text-muted ">
                            <a href="# " class="card-link ">More Events</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 ">
                <div class="bs-ccomponent ">
                    <div class="card mb-3 " style="box-shadow: 1px 1px 5px #ddd; ">
                        <h3 class="card-header " style="border-bottom: 10px solid #f36833 ">Top Communities</h3>
                        <div class="card-body ">
                            <h5 class="card-title " style="font-size: 1.2em ">Feupinhos</h5>
                            <h6 class="card-subtitle text-muted ">521 members</h6>
                        </div>
                        <img style="width: 100%; height: 200px; object-fit: cover; " src="img/caloiros.jpg " alt="Card image ">
                        <div class="card-body ">
                            <p class="card-text ">O grupo dos feupinhos é um grupo publico da comunidade de caloiros da Faculdade de Engenharia da Universidade do
                                Porto. Este é o local em que todos os "noobs " devem estar.
                            </p>
                        </div>
                        <ul class="list-group list-group-flush ">
                            <li class="list-group-item " style="font-size: 1.2em ">Desajeitados</li>
                            <li class="list-group-item " style="font-size: 1.2em ">Os Lambe Botas</li>
                            <li class="list-group-item " style="font-size: 1.2em ">Primeiros dos ultimos</li>
                        </ul>
                        <div class="card-footer text-muted ">
                            <a href="# " class="card-link " style="color: #f36833; ">More Communities</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col ">
                <br>
                <div class="jumbotron " style="padding: 25px ">
                    <h1 class="display-5 ">Questions?</h1>
                    <p class="lead ">Need help? This is just a bit of what our platform has to offer. You can see events, join them, buy tickets, be part
                        of a community and much more. Besides this you might need more help to understand all about! Consult our FAQ pages.
                    </p>
                    <p class="lead ">
                        <a class="btn btn-primary btn-lg " href="faq" role="button ">Take me there</a>
                    </p>
                </div>
            </div>
        </div>
@endsection