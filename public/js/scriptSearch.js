'use strict';

let container = document.querySelector('.container');
let containerCopy = container.innerHTML;

let searchFormInput = document.querySelector('input[id=search_text]');

searchFormInput.addEventListener('keyup', searchEvent);


function searchEvent(event) {
    let request = new XMLHttpRequest();
    request.open('get', 'search?' + encodeForAjax({'searchField': searchFormInput.value}), true);
    request.addEventListener('load', searchEventsReceived);
    request.send();

    event.preventDefault();
}

function searchEventsReceived(){
    console.log("entra");
    let lines = JSON.parse(this.responseText);
    container.innerHTML = '';

    console.log(lines);

    lines.forEach(function(data){
        console.log(data);
        container.innerHTML = data + "<br>"
    });

    if(searchFormInput.value == '')
        container.innerHTML = containerCopy;

}

function encodeForAjax(data) {
    return Object.keys(data).map(function(k){
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&');
}