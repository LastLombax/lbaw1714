@extends('layout')

@section('content')
    <div class="container">
        <legend style=" color: #333; padding: 20px; margin-left: 0; padding-left: 0; padding-bottom: 0;">
            <i class="fas fa-at"></i>
            <span style="margin-left: .5rem;">
                Contact us
            </span>
        </legend>

        <div class="bs-docs-section">
            <div class="row">

                <div class="col-lg-2"></div>
                <div class="col-lg-8" style="padding-top: 23px;">

                    <div class="col-lg-12" style="padding-left: 0; padding-right:0;">
                        <div class="bs-ccomponent">

                            <div style="background-color: #eee; padding: 20px; padding-top: 10px;">
                                <fieldset>
                                    <div class="form-group">
                                        <label class="col-form-label" for="inputDefault">
                                            <b>Your name</b>
                                        </label>
                                        <input type="text" class="form-control" placeholder="Name" id="inputDefault">
                                    </div>

                                    <div class="form-group">
                                        <label class="col-form-label" for="inputDefault">
                                            <b>Your e-mail address</b>
                                        </label>
                                        <input type="email" class="form-control" placeholder="E-mail address" id="inputDefault">
                                    </div>

                                    <div class="form-group">
                                        <label class="col-form-label" for="inputDefault">
                                            <b>Your message</b>
                                        </label>
                                        <textarea class="form-control" placeholder="Write your message here..." id="inputDefault"></textarea>
                                    </div>

                                    <button type="submit" onclick="event.preventDefault(); location.href = 'createEvent2.html';"
                                            class="btn btn-primary">Send</button>
                                </fieldset>

                            </div>
                            <div class="progress">
                                <div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0"
                                     aria-valuemax="100"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2"></div>

            </div>
        </div>
    </div>
@endsection