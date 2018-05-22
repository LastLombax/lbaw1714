<div class="list-group">
    <div class="list-group-item list-group-item-action flex-column align-items-start">
            <table>
                <tr>
                    <td>
                        <a href="{{route('member', $member->username)}}">
                            <img src="{{$member->imagePath()}}" style="width: 20%; height: 100px; object-fit: cover; float:left;">
                        </a>
                    </td>
                    <td>
                        <h5>{{$member->username}}</h5>
                    </td>
                </tr>
            </table>
    </div>
</div>