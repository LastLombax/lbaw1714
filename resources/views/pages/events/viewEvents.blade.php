@extends('layout')

@section('searchBody')
    <div class="row justify-content-center align-items-center">

        <div class="col-md-3  align-self-start">
            <div style="padding-left: 15px; padding-top: 15px">


            @if (!Auth::guest())
                <fieldset>
                    <label class="control-label">Event Range</label>
                    <div class="form-group">
                        <div class="form-group">
                            <select id="selectedRange" class="custom-select">
                                <option selected="" value="all">All Events</option>
                                <option value="my">My events</option>
                            </select>
                        </div>
                        <label class="control-label">Search by Country</label>
                        <div class="form-group">
                            <select id="selectedCountry" class="custom-select">
                                <option selected="" value="Select Country">All Countries</option>
                                @foreach(App\Country::all() as $country)
                                    <option value="{{$country->idcountry}}">{{$country->name}}</option>
                                @endforeach
                            </select>
                        </div>
                        <label class="control-label">Search between ticket prices</label>
                        <div class="form-group">
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">$</span>
                                </div>
                                <input id="minPrice" type="text" placeholder="Min Price" class="form-control"
                                       aria-label="Amount (to the nearest dollar)" >
                                <div class="input-group-append">
                                    <span class="input-group-text">.00</span>
                                </div>
                            </div>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">$</span>
                                </div>
                                <input id="maxPrice" type="text" placeholder="Max Price" class="form-control"
                                       aria-label="Amount (to the nearest dollar)">
                                <div class="input-group-append">
                                    <span class="input-group-text">.00</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row align-self-start">

                        <div class="col-sm-6" style="min-width: 200px;">
                            <div class="form-group" id="selectedOrder">
                                <label class="control-label">Order by</label>
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="customRadio1" name="customRadio"
                                           class="custom-control-input"
                                           checked="" value="top">
                                    <label class="custom-control-label" for="customRadio1" >Top Events</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="customRadio2" name="customRadio"
                                           class="custom-control-input" value="chrono">
                                    <label class="custom-control-label" for="customRadio2">Chronological Events</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="customRadio3" name="customRadio"
                                           class="custom-control-input"
                                           disabled="">
                                    <label class="custom-control-label" for="customRadio3">Nearby Events</label>
                                </div>
                            </div>
                        </div>

                    </div>
                </fieldset>
                @endif
            </div>
        </div>

        <div class="col-md-9  align-self-start" style="padding-top: 15px; padding-left: 30px;">
            <div class="searchContainer">
            </div>

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