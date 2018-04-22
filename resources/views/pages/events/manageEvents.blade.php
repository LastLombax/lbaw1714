@extends('layout')

@section('title')
   Your Events | ReEvent
@endsection

@section('titleIcon')
    <i class="fas fa-calendar-check"></i>
@endsection

@section('pageTitle')
    Your Events
@endsection

@section('content')

 <div class="container">
     <div id="nearby-events">

        <div class="bs-docs-section">
          <div class="row" style="width: 100%">
          @include('pages.events.manageEventsFragment')

          </div>
         
        </div>
      </div>

  </div>
@endsection




