'use strict';

let siteRoot = document.location.origin; //"http://localhost:8000/"

let container = document.querySelector('.searchFriendsContainer');
let timeline = document.querySelector('#time');
let timelineCopy;

if(timeline != null){
    timelineCopy = timeline.innerHTML;
}


let containerCopy = container.innerHTML;
let searchFormInput = document.querySelector('input[id=search_text]');

window.addEventListener('load', searchFriend);

searchFormInput.addEventListener('keyup', searchFriend);

searchFormInput.addEventListener('submit', function (event) {
    event.preventDefault();
})

function searchFriend(event) {
    let request = new XMLHttpRequest();
    request.open('get', siteRoot + '/searchCommunity?' + encodeForAjax({'searchField': searchFormInput.value}), true);
    request.addEventListener('load', searchFriendsReceived);
    request.send();

    event.preventDefault();
}

function searchFriendsReceived(){
    let lines = JSON.parse(this.responseText);


    container.innerHTML = '';

    if(timeline != null)
        timeline.innerHTML = '';

    let div1 = document.createElement('div');
    div1.classList.add('nearby-events');

    div1.innerHTML =
        '        <br>' +
        '        <legend style=" color: #333; padding: 20px; margin-left: 0; padding-left: 0;">\n' +
        '            <i class="fas fa-calendar-check"></i>\n' +
        '            <span style="margin-left: .5rem;">\n' +
        '             Community Search Results\n' +
        '          </span>\n' +
        '        </legend>\n';

    let div2 = document.createElement('div');
    div2.classList.add('bs-docs-section');

    let div3 = document.createElement('div');
    div3.classList.add('row', 'justify-content-center',  'align-items-center');


    lines.forEach(function(data){

        let link = siteRoot + '/communities/' + data.idcommunity;

        let image = '/storage/' + data.profilepicture;

        div3.innerHTML +=
            '            <div class="col-lg-4 align-self-start">\n' +
            '              <div class="bs-ccomponent">\n' +
            '                <div class="card mb-4" style="box-shadow: 1px 1px 30px #ddd;">\n' +
            '                  <div class="card-body">\n' +
            '                  <h3 class="card-title" style="background-color: #fff;">' +
            '                   <a style="color: #000;" href="'+link+'">'
            + data.name +
            '</a>' +
            '                      </h3>\n' +
            '                  </div>\n' +
            '                  <img style="width: 100%; height: 200px; object-fit: cover;" src="' + image + '" alt="Card image">\n' +
            '                  <div class="card-body">\n' +
            '                    <p class="card-text">'+ data.description +'</p>\n' +
            '                  </div>\n' +
            '                  <div class="card-footer text-muted" style="background-color: #fff; text-align: right;">\n' +
            '                    <a href="' + link + '" class="card-link">Open</a>\n' +
            '                  </div>\n' +
            '                </div>\n' +
            '              </div>\n' +
            '            </div>';
    });


    div1.append(div2);
    div2.append(div3);

    container.append(div1);

}

function encodeForAjax(data) {
    return Object.keys(data).map(function(k){
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&');
}