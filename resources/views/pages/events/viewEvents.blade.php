@extends('layout')

@section('searchBody')
    <div class="row justify-content-center align-items-center" >

        <div class="col-md-3  align-self-start">
            <div style="padding-left: 15px; padding-top: 15px">

                <fieldset>
                    <div class="form-group">
                        <label class="control-label">Input addons</label>
                        <div class="form-group">
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">$</span>
                                </div>
                                <input type="text" class="form-control" aria-label="Amount (to the nearest dollar)">
                                <div class="input-group-append">
                                    <span class="input-group-text">.00</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="custom-control custom-radio">
                            <input type="radio" id="customRadio1" name="customRadio" class="custom-control-input" checked="">
                            <label class="custom-control-label" for="customRadio1">Toggle this custom radio</label>
                        </div>
                        <div class="custom-control custom-radio">
                            <input type="radio" id="customRadio2" name="customRadio" class="custom-control-input">
                            <label class="custom-control-label" for="customRadio2">Or toggle this other custom radio</label>
                        </div>
                        <div class="custom-control custom-radio">
                            <input type="radio" id="customRadio3" name="customRadio" class="custom-control-input" disabled="">
                            <label class="custom-control-label" for="customRadio3">Disabled custom radio</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="custom-control custom-checkbox">
                            <input type="checkbox" class="custom-control-input" id="customCheck1" checked="">
                            <label class="custom-control-label" for="customCheck1">Check this custom checkbox</label>
                        </div>
                        <div class="custom-control custom-checkbox">
                            <input type="checkbox" class="custom-control-input" id="customCheck2" disabled="">
                            <label class="custom-control-label" for="customCheck2">Disabled custom checkbox</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <select class="custom-select">
                            <option selected="">Open this select menu</option>
                            <option value="1">One</option>
                            <option value="2">Two</option>
                            <option value="3">Three</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <div class="input-group mb-3">
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="inputGroupFile02">
                                <label class="custom-file-label" for="inputGroupFile02">Choose file</label>
                            </div>
                            <div class="input-group-append">
                                <span class="input-group-text" id="">Upload</span>
                            </div>
                        </div>
                    </div>
                </fieldset>

            </div>
        </div>

        <div class="col-md-9  align-self-start" style="padding-top: 15px;">
            @include('pages.events.viewTopEvents')

            <br><br><br>
            <div style="width: 185px; margin: 0 auto;">
                <ul class="pagination" style="box-shadow: 1px 1px 20px #ddd">
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

    </div>
@endsection