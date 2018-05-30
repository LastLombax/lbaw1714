function addMeToEvent(event) {


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
        addBt.innerHTML = '<button style="width: 130px; margin-bottom: 2px;" type="button" class="btn btn-success disabled">Joined</button>\n';
    }

}