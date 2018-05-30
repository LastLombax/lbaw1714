try {
    siteRoot = document.location.origin; //"http://localhost:8000/"
}
catch (e) {
    let siteRoot = document.location.origin; //"http://localhost:8000/"

}

let usernameField = document.querySelector('#usernameField');

usernameField.addEventListener('keyup', searchFriend);


function searchFriend(event){
   // if (typeof event != "undefined")
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
                                '<h6 id="inviteBt-'+data.idmember+'">' +
                                    '<button type="button" name="sendInviteBt" class="btn btn-info" onclick="sendEventInvite('+data.idmember+');" id="'+ data.idmember +'">' +
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

