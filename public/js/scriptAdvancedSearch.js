let siteRoot = document.location.origin; //"http://localhost:8000/"

let container = document.querySelector('.searchContainer');
let selectedRange = document.querySelector('#selectedRange');
let selectedCountry = document.querySelector('#selectedCountry');
let minPrice = document.querySelector('#minPrice');
let maxPrice = document.querySelector('#minPrice');

console.log(selectedRange);
console.log(selectedCountry);
console.log(minPrice);
console.log(maxPrice);
console.log(selectedOrder);

let searchFormInput = document.querySelector('input[id=search_text]');

searchFormInput.addEventListener('keyup', searchEvent);

function searchEvent(event) {
    let request = new XMLHttpRequest();
    request.open('get', siteRoot + '/search?' + encodeForAjax({'searchField': searchFormInput.value}), true);
    request.addEventListener('load', searchEventsReceived);
    request.send();

    event.preventDefault();
}

window.addEventListener("load", function() {

    console.log('JANELAAAAAA');

    let request = new XMLHttpRequest();
    request.open('get', siteRoot + '/search?' + encodeForAjax({'searchField': searchFormInput.value}), true);
    request.addEventListener('load', searchEventsReceived);
    request.send();

    event.preventDefault();
});

selectedRange.addEventListener("change", function() {
    let newSelectedRange = document.querySelector('#selectedRange [selected=""]');

    console.log('ENTRA SELECTED RANGE');

    let request = new XMLHttpRequest();
    request.open('get', siteRoot + '/search?' + encodeForAjax({'searchField': searchFormInput.value}), true);
    request.addEventListener('load', searchEventsReceived);
    //request.send();

    event.preventDefault();
});

selectedCountry.addEventListener("change", function() {
    let newSelectedCountry = document.querySelector('#selectedCountry [selected=""]');

    console.log('ENTRA SELECTED COUNTRY');

    let request = new XMLHttpRequest();
    request.open('get', siteRoot + '/search?' + encodeForAjax({'searchField': searchFormInput.value}), true);
    request.addEventListener('load', searchEventsReceived);
    //request.send();

    event.preventDefault();
});

minPrice.addEventListener("change", function() {
    let newMinPrice = document.querySelector('#minPrice');

    console.log('ENTRA MIN PRICE');

    let request = new XMLHttpRequest();
    request.open('get', siteRoot + '/search?' + encodeForAjax({'searchField': searchFormInput.value}), true);
    request.addEventListener('load', searchEventsReceived);
    //request.send();

});

maxPrice.addEventListener("change", function() {
    let newMaxPrice = document.querySelector('#minPrice');

    console.log('ENTRA MAX PRICE');

    let request = new XMLHttpRequest();
    request.open('get', siteRoot + '/search?' + encodeForAjax({'searchField': searchFormInput.value}), true);
    request.addEventListener('load', searchEventsReceived);
    //request.send();

});

let selectedOrders = document.querySelectorAll('#selectedOrder [name="customRadio"]');
var prev = null;
for(var i = 0; i < selectedOrders.length; i++) {
    selectedOrders[i].onclick = function() {

        //console.log(this.value)

        console.log('ENTRA SELECTED ORDER BY');

        let request = new XMLHttpRequest();
        request.open('get', siteRoot + '/search?' + encodeForAjax({'searchField': searchFormInput.value}), true);
        request.addEventListener('load', searchEventsReceived);
        //request.send();

    };
}








function searchEventsReceived(){
    let lines = JSON.parse(this.responseText);

    container.innerHTML = '';

    let div1 = document.createElement('div');
    div1.classList.add('nearby-events');

    let div2 = document.createElement('div');
    div2.classList.add('bs-docs-section');

    let div3 = document.createElement('div');
    div3.classList.add('row', 'justify-content-center',  'align-items-center');


    lines.forEach(function(data){
        console.log(data);

        let link = siteRoot + '/events/' + data.idevent;

        let image = '/storage/' + data.imagepath;

        div3.innerHTML +=
            '            <div class="col-lg-4 align-self-start">\n' +
            '              <div class="bs-ccomponent">\n' +
            '                <div class="card mb-4" style="box-shadow: 1px 1px 30px #ddd;">\n' +
            '                  <div class="card-body">\n' +
            '                  <h3 class="card-title" style="background-color: #fff;"><a style="color: #000;" href="{{asset(\\\'events/\' + data.idevent +\'\\\')}}">' + data.name + '</a></h3>\n' +
            '                    <h6 class="card-subtitle text-muted">' + data.startday + '</h6>\n' +
            '                  </div>\n' +
            '                  <img style="width: 100%; height: 200px; object-fit: cover;" src="' + image + '" alt="Card image">\n' +
            '                  <div class="card-body">\n' +
            '                    <p class="card-text">'+ data.description +'</p>\n' +
            '                  </div>\n' +
            '                  <div class="card-footer text-muted" style="background-color: #fff; text-align: right;">\n' +
            '                    <a href="' + link + '" class="card-link">Open event</a>\n' +
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

}

function encodeForAjax(data) {
    return Object.keys(data).map(function(k){
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&');
}