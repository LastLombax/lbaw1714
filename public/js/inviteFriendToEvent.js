function sendEventInvite(sendInviteBt){

    let request = new XMLHttpRequest();

    request.open('POST', siteRoot + '/inviteToEvent', true);

    request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);
    request.setRequestHeader("Content-type", "application/json");

    request.addEventListener('load', eventInviteRequest.bind(sendInviteBt));

    let eventId = document.querySelector('.friendsBody').getAttribute('id');

    let data = {'friendId': sendInviteBt, 'eventId': eventId};

    request.send(JSON.stringify(data));
}

function eventInviteRequest(response){
    let lines = JSON.parse(response.originalTarget.responseText);




    if(lines){
        let inviteBt = document.querySelector('#inviteBt-' + this);
        inviteBt.innerHTML = '<button type="button" class="btn btn-success disabled">Invited</button>\n';
    }
    else {
        let inviteBt = document.querySelector('#inviteBt-' + this);
        inviteBt.innerHTML = '<button type="button" class="btn btn-danger disabled">Already Joined/Invited</button>\n';
    }

}