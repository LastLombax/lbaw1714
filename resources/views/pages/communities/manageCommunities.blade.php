@extends('layout')

@section('title')
   Your Communities | ReEvent
@endsection

@section('titleIcon')
    <i class="fas fa-calendar-check"></i>
@endsection

@section('pageTitle')
    Your Communities
@endsection

@section('content')

 <div class="container">
     <div id="manage-communities">

        <div class="bs-docs-section">
          <div class="row" style="width: 100%">
          @include('pages.communities.manageCommunitiesFragment')
          </div>
         
        </div>
      </div>

  </div>
@endsection




