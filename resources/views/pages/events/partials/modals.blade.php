<div class="modal fade" id="modalInvite" tabindex="-1" role="dialog" aria-labelledby="modalInviteTitle"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <form method="POST" action="{{route('inviteEvent', $event)}}" class="modal-content">
            {{ csrf_field()}}
            <div class="modal-header">
                <h5 class="modal-title" id="modalInviteTitle">Invite people</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="text" name="usernameField" id="usernameField" placeholder="Input username..."/>
                <!--<input type="button" name="search_button" id="search_button">-->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary">Send invite</button>
            </div>
        </form>
    </div>
</div>

<div class="modal fade" id="modalBuyTicket" tabindex="-1" role="dialog" aria-labelledby="modalBuyTicket"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <form method="POST" action="{{route('inviteEvent', $event)}}" class="modal-content">
            {{ csrf_field()}}
            <div class="modal-header">
                <h5 class="modal-title" id="modalInviteTitle">Invite people</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="text" name="usernameField" id="usernameField" placeholder="Input username..."/>
                <!--<input type="button" name="search_button" id="search_button">-->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary">Send invite</button>
            </div>
        </form>
    </div>
</div>