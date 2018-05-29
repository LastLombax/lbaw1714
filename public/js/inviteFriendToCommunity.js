function sendEventInvite(){

    let sendInviteBt = document.querySelector('button[name=sendInviteBt]').getAttribute('id');

    let request = new XMLHttpRequest();

    request.open('POST', siteRoot + '/inviteToCommunity', true);

    request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);
    request.setRequestHeader("Content-type", "application/json");

    request.addEventListener('load', eventInviteRequest);

    let eventId = document.querySelector('.friendsBody').getAttribute('id');

    let data = {'friendId': sendInviteBt, 'communityId': eventId};

    request.send(JSON.stringify(data));
}

function eventInviteRequest(){
    let lines = JSON.parse(this.responseText);

    if(lines){
        let inviteBt = document.querySelector('#inviteBt');
        inviteBt.innerHTML = '<button type="button" class="btn btn-success disabled">Invited</button>\n';
    }
    else {
        let inviteBt = document.querySelector('#inviteBt');
        inviteBt.innerHTML = '<button type="button" class="btn btn-danger disabled">Already Joined/Invited</button>\n';
    }

}