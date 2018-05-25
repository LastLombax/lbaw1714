let befriendBtn = document.querySelector(".befriendBtn");

befriendBtn.addEventListener('click', function (event) {
    event.preventDefault();

    let siteRoot = document.location.origin; //"http://localhost:8000/"
    let friendId = document.querySelector(".befriendBtn").getAttribute('id');

    console.log(friendId);

    let request = new XMLHttpRequest();

    request.open('POST', siteRoot + '/sendFriendNotification', true);

    request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);
    request.setRequestHeader("Content-type", "application/json");

    request.addEventListener('load', friendResponse);

    let data = {'idfriend': friendId};

    request.send(JSON.stringify(data));
});

function friendResponse(){
    let lines = JSON.parse(this.responseText);

    if(lines){
        befriendBtn.innerHTML = '' +
            '<i class="fas fa-check"></i>' +
            'Friend Request Sent';
    }

}

