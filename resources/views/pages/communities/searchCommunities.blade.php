@extends('layout')

@section('searchBody')
    <div class="row justify-content-center align-items-center">

        <div class="col-md-9  align-self-start" style="padding-top: 15px; padding-left: 30px;">
            <div class="searchFriendsContainer">
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