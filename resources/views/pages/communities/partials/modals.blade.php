<div class="modal fade" id="modalInvite" tabindex="-1" role="dialog" aria-labelledby="modalInviteTitle"
     aria-hidden="true">
    <div class="modal-dialog" role="document">

        <div class="modal-header">
            <h5 class="modal-title" id="modalInviteTitle">Invite people</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body">

            <div class="form-group" style="width: 100%;">
                <input class="form-control form-control-lg" id="usernameField" type="text"
                       placeholder="Input username..." id="inputLarge">
            </div>

            <div class="friendsBody" id="{{$community->idcommunity}}">

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
    </div>
</div>