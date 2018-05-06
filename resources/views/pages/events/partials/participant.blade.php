<div class="list-group">
    <a href="#"
       class="list-group-item list-group-item-action flex-column align-items-start">
        <a href="{{route('profile', $member->username)}}">
        <img src="{{$member->imagePath()}}"
             style="width: 20%; height: 100px; object-fit: cover; float:left;">
        </a>
        <h5>{{$member->username}}</h5>
    </a>
</div>