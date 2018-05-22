<div class="list-group">
    <div class="list-group-item list-group-item-action flex-column align-items-start">
            <table style="width: 100%; text-align: right;">
                <tr>
                    <td style="width: 100px;">
                        <a href="{{route('member', $member->username)}}">
                            <img src="{{$member->imagePath()}}" style="width: 100px; height: 100px; object-fit: cover; float:left;">
                        </a>
                    </td>
                    <td>
                        <h5 style="text-align: right;">{{$member->username}}</h5>
                    </td>
                </tr>
            </table>
    </div>
</div>