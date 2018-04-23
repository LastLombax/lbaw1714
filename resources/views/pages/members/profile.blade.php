@extends('layout')

@section('content')

    <div class="container">
        <legend style=" color: #333; padding: 20px; margin-left: 0; padding-left: 0; padding-bottom: 0;">
            <svg class="svg-inline--fa fa-user fa-w-16" aria-hidden="true" data-prefix="fas" data-icon="user" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M256 0c88.366 0 160 71.634 160 160s-71.634 160-160 160S96 248.366 96 160 167.634 0 256 0zm183.283 333.821l-71.313-17.828c-74.923 53.89-165.738 41.864-223.94 0l-71.313 17.828C29.981 344.505 0 382.903 0 426.955V464c0 26.51 21.49 48 48 48h416c26.51 0 48-21.49 48-48v-37.045c0-44.052-29.981-82.45-72.717-93.134z"></path></svg><!-- <i class="fas fa-user"></i> -->
            <span style="margin-left: .5rem;">
                <b> {{$member->username}}'s</b> profile
            </span>
        </legend>

        <div class="bs-docs-section">
            <div class="row">


                <div class="col-lg-4" style="padding-top: 23px;">
                    <div class="bs-ccomponent">
                        <img src="img/god.jpg" style="width: 100%; height: 200px; object-fit: cover;">
                        <br>
                        <br>

                        <div class="col-lg-12" style="padding-left: 0; padding-right:0;">
                            <div class="bs-ccomponent">

                                <div style="background-color: #eee; padding: 20px; padding-top: 10px;">
                                    <fieldset>
                                        <div class="form-group">
                                            <label class="col-form-label" for="inputDefault">
                                                <b>Name</b>
                                            </label>
                                            <p>Sir Incredible, God</p>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-form-label" for="inputDefault">
                                                <b>About</b>
                                            </label>
                                            <p>Hello, I am God, I'm here to, as usual, create stuff, and in this case, events and some communities.
                                            I also want to participate in some as well!</p>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-form-label" for="inputDefault">
                                                <b>Birthdate</b>
                                            </label>
                                            <p>Unknown</p>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-form-label" for="inputDefault">
                                                <b>Email address</b>
                                            </label>
                                            <p>
                                                <a href="#">godsemail@godcorporation.god</a>
                                            </p>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-form-label" for="inputDefault">
                                                <b>Address</b>
                                            </label>
                                            <p>
                                                <a href="#">Royal Heaven Street, 7 H7</a>
                                            </p>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-form-label" for="inputDefault">
                                                <b>Country</b>
                                            </label>
                                            <p>Heavenlandia</p>
                                        </div>
                                    <br>
                                    <br>
                                    <br>
                                    <br>
                                    <div style="text-align: right;">
                                        <span class="badge badge-info">Member</span>
                                        <span class="badge badge-dark">Administrator</span>
                                    </div>
                                </fieldset></div>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-8" style="padding-top:23px">
                    <ul class="nav nav-tabs">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#feed">Activity Feed</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#upcoming">Upcoming Events</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#history">Event History</a>
                        </li>
                    </ul>

                    <div id="myTabContent" class="tab-content">
                        <div class="tab-pane fade show active" id="feed">
                            <div class="col-lg-12" style="padding-left: 0px;padding-right: 0px;">
                                <div class="bs-ccomponent">
                                    <div class="list-group">
                                        <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
                                                <h5 class="mb-1">God created a new Event in Community Feupinhos: Feupinhos na Queima</h5>
                                                <small>1 day ago</small>
                                        </a>
                                        <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
                                                <h5 class="mb-1">Feupinhos attended an Event with Feupinhos: Synergy in FEUP</h5>
                                                <small class="text-muted">2 days ago</small>
                                        </a>
                                            <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
                                                    <h5 class="mb-1">God is attending an Event: Super Bock Super Rock</h5>
                                                <small class="text-muted">3 days ago</small>
                                        </a>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="upcoming">
                            <div class="col-lg-12" style="padding-left: 0px;padding-right: 0px;">
                                <div class="bs-ccomponent">
                                    <div class="list-group">

                                        <div class="list-group-item list-group-item-action flex-column align-items-start">
                                            <div class="d-flex w-100 justify-content-between">
                                                <h5 class="mb-1">Piggybank Party</h5>
                                                <small>Tomorrow</small>
                                            </div>
                                            <p class="mb-1">A party for all Piggybank lovers!</p>
                                        <a href="">
                                            <small> Click here to see your ticket.</small>
                                        </a>
                                    </div>
                                        <div class="list-group-item list-group-item-action flex-column align-items-start">
                                            <div class="d-flex w-100 justify-content-between">
                                                <h5 class="mb-1">Feupinhos na Queima</h5>
                                                <small>In 65 days</small>
                                            </div>
                                            <p class="mb-1">O melhor evento da Queima das Fitas!</p>
                                        <a href="">
                                            <small> Click here to see your ticket.</small>
                                        </a>
                                    </div>
                                    <div class="list-group-item list-group-item-action flex-column align-items-start">
                                        <div class="d-flex w-100 justify-content-between">
                                            <h5 class="mb-1">Super Bock Super Rock</h5>
                                            <small>In 138 days</small>
                                        </div>
                                        <p class="mb-1"> Muita cerveja e muita música!</p>
                                        <a href="">
                                            <small> Click here to see your ticket.</small>
                                        </a>
                                </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="history">
                            <div class="col-lg-12" style="padding-left: 0px;padding-right: 0px;">
                                <div class="bs-ccomponent">
                                    <div class="list-group">
                                        <div class="list-group-item list-group-item-action flex-column align-items-start">
                                            <div class="d-flex w-100 justify-content-between">
                                                <a href="">
                                                    <h5 class="mb-1">LBAW A1</h5>
                                                </a>
                                                <small>1 week ago</small>
                                            </div>
                                            <p class="mb-1">Event to deliver the 1st Artifact of LBAW</p>
                                        <a href="">
                                            <small> Click here to see your ticket.</small>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div style="margin-top: 1rem; margin-left: 0;">
                    <ul class="pagination" style="">
                        <li class="page-item disabled ">
                            <a class="page-link " href="# ">«</a>
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
                            <a class="page-link " href="# ">»</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <footer id="footer " style="margin: 1em 0; padding-bottom: 2em; border-top: 1px solid #ddd; ">
            <br>
            <div class="row ">
                <div class="col-lg-12 ">

                    <table class="list-unstyled " cellpadding="7 " style="font-size: 0.9375rem; margin: 0 auto; ">
                        <tbody><tr>
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
                    </tr></tbody></table>
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
        </div>

        <!-- Yeti Template Ends Here -->

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>



</div>
@endsection

