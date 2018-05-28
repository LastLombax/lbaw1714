@extends('layout')

@section('title')
    FAQ | ReEvent
@endsection

@section('titleIcon')
    <i class="fas fa-question"></i>
@endsection

@section('pageTitle')
    Frequently Asked Questions
@endsection


@section('content')
        <div>
            <h3>What is a Member?</h3>
            <p>
                A member is a registered user. By registering, a member can create events and communities, as well as being able to interact with other members.
            </p>

            <h3>How do I create an event?</h3>
            <p>
                To create an event, all you need is go <a href="http://localhost:8000/events/create">here</a> and fill the form.
            </p>

            <h3>What is the answer to life, the universe and everything?</h3>
            <p>
                Did you mean: <strong>How much is seven times six?</strong>
            </p>

            <h3>What can communities do?</h3
>            <p>
                A community is a group of members that can create events and easily add all members within the community.  
            </p>
        </div>
@endsection

