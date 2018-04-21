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
    let lines = JSON.parse(this.responseText);
    container.innerHTML = '';

    let div1 = document.createElement('div');
    div1.classList.add('nearby-events');

    div1.innerHTML =
        '        <legend style=" color: #333; padding: 20px; margin-left: 0; padding-left: 0;">\n' +
        '            <i class="fas fa-calendar-check"></i>\n' +
        '            <span style="margin-left: .5rem;">\n' +
        '            Search Results\n' +
        '          </span>\n' +
        '        </legend>\n';

    let div2 = document.createElement('div');
    div2.classList.add('bs-docs-section');

    let div3 = document.createElement('div');
    div3.classList.add('row', 'justify-content-center',  'align-items-center');


    lines.forEach(function(data){
        console.log(data);
        div3.innerHTML +=
            '            <div class="col-lg-4">\n' +
            '              <div class="bs-ccomponent">\n' +
            '                <div class="card mb-4">\n' +
            '                  <h3 class="card-header" style="border-bottom: 10px solid #158cb8">' + data.name + '</h3>\n' +
            '                  <div class="card-body">\n' +
            '                    <h6 class="card-subtitle text-muted">' + data.startDay + '</h6>\n' +
            '                  </div>\n' +
            '                  <img style="width: 100%; height: 200px; object-fit: cover;" src="'+ data.imagepath +'" alt="Card image">\n' +
            '                  <div class="card-body">\n' +
            '                    <p class="card-text">'+ data.description +'</p>\n' +
            '                  </div>\n' +
            '                  <div class="card-footer text-muted">\n' +
            '                    <a href="{{asset(\'events/' + data.idevent +'\')}}" class="card-link">Open event</a>\n' +
            '                  </div>\n' +
            '                </div>\n' +
            '              </div>\n' +
            '            </div>';
    });

    console.log(div3);
    console.log(div2);
    console.log(div1);

    div1.append(div2);
    div2.append(div3);

    container.append(div1);
    
    if(searchFormInput.value == '')
        container.innerHTML = containerCopy;

}

function encodeForAjax(data) {
    return Object.keys(data).map(function(k){
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&');
}