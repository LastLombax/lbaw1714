@extends('layout')

@section('content')
    <div class="bs-docs-section" style="margin-right: 10%; margin-left: 10%;">
        <div class="row justify-content-center align-items-center" >

            @include('pages.events.viewTopEvents')

            <br><br><br>
            <div>
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