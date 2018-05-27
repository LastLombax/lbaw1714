let usernameField = document.querySelector('#usernameField');

usernameField.addEventListener('keyup', searchFriend);


function searchFriend(){
    event.preventDefault();

    let friendUsername = document.querySelector('#usernameField').value;

    let request = new XMLHttpRequest();

    request.open('POST', siteRoot + '/searchFriends', true);

    request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);
    request.setRequestHeader("Content-type", "application/json");

    request.addEventListener('load', friendList);

    let eventId = document.querySelector('.friendsBody').getAttribute('id');

    let data = {'friendUsername': friendUsername, 'eventId': eventId};

    request.send(JSON.stringify(data));
}


function friendList() {
    let lines = JSON.parse(this.responseText);

    var friendsBody = document.querySelector('.friendsBody');

    friendsBody.innerHTML = '';

    if(document.querySelector('#usernameField').value == '')
        return;

    lines.forEach(function(data){

        let image;
        if(data.imagepath == null)
            image = siteRoot + '/storage/img/member/defaultMember.png';
        else
            image = siteRoot + '/storage/app/public/img/member/' + data.imagepath;

        friendsBody.innerHTML +=
            '<div class="list-group"> ' +
                '<div class="list-group-item flex-column align-items-start" id="selectedFriend" style="border:none; background-color: #eee"> ' +
                    '<table style="width:100%; text-align: center;"> ' +
                        '<tr> ' +
                            '<td style="width:33.33%;"> ' +
                                '<img style="width: 100px; height: 100px; object-fit: cover;" src="'+ image +'" alt="toobad">' +
                            '</td> ' +
                            '<td style="width:33.33%;"> ' +
                                '<h6>'+ data.username +'</h6> ' +
                            '</td> ' +
                            '<td style="width:33.33%;"> ' +
                                '<h6 id="inviteBt">' +
                                    '<button type="button" class="btn btn-info" onclick="sendEventInvite();" id="'+ data.idmember +'">' +
                                        'Invite' +
                                    '</button>' +
                                '</h6> ' +
                            '</td>' +
                        '</tr>' +
                    '</table>' +
                '</div> ' +
            '</div>';
    });
}

function sendEventInvite(){
    event.preventDefault();

    let request = new XMLHttpRequest();

    request.open('POST', siteRoot + '/inviteToEvent', true);

    request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);
    request.setRequestHeader("Content-type", "application/json");

    request.addEventListener('load', eventInviteRequest);

    let eventId = document.querySelector('.friendsBody').getAttribute('id');

    let data = {'friendId': event.target.attributes.id.value, 'eventid': eventId};

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
        inviteBt.innerHTML = '<button type="button" class="btn btn-danger disabled">Already Invited</button>\n';
    }

}

function addMeToEvent() {
    event.preventDefault();

    let request = new XMLHttpRequest();

    request.open('POST', siteRoot + '/addMeToEvent', true);

    request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);
    request.setRequestHeader("Content-type", "application/json");

    request.addEventListener('load', addMeResponse);

    let eventId = document.querySelector('.friendsBody').getAttribute('id');

    let data = {'eventId': eventId};

    request.send(JSON.stringify(data));
}

function addMeResponse(){
    let lines = JSON.parse(this.responseText);

    if(lines){
        let addBt = document.querySelector('#addMeBt');
        addBt.innerHTML = '<button type="button" class="btn btn-success disabled">Joined</button>\n';
    }

}