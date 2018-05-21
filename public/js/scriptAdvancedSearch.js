let siteRoot = document.location.origin; //"http://localhost:8000/"

let container = document.querySelector('.searchContainer');
let selectedRange = document.querySelector('#selectedRange');
let selectedCountry = document.querySelector('#selectedCountry');
let minPrice = document.querySelector('#minPrice');
let maxPrice = document.querySelector('#maxPrice');

let newSelectedRange;
let newSelectedCountry;
let newMinPrice;
let newMaxPrice;
let newSelectedOrder;

console.log(selectedRange);
console.log(selectedCountry);
console.log(minPrice);
console.log(maxPrice);
console.log(selectedOrder);

let searchFormInput = document.querySelector('input[id=search_text]');

searchFormInput.addEventListener('keyup', searchEvent);

function getSelectedOption(sel) {
    var opt;
    for ( var i = 0, len = sel.options.length; i < len; i++ ) {
        opt = sel.options[i];
        if ( opt.selected === true ) {
            break;
        }
    }
    return opt.getAttribute('value');
}

function searchEvent(event) {
    let request = new XMLHttpRequest();

    if(document.querySelector('#selectedRange [value="all"]').selected)
        newSelectedRange = "all";
    else if(document.querySelector('#selectedRange [value="my"]').selected)
        newSelectedRange = "my";

    newSelectedCountry = getSelectedOption(document.getElementById('selectedCountry'));
    newMinPrice = document.querySelector('#minPrice').value;
    newMaxPrice = document.querySelector('#maxPrice').value;
    if(document.querySelector('#selectedOrder [value="top"]').checked) {
        newSelectedOrder = "top";
    }else if(document.querySelector('#selectedOrder [value="chrono"]').checked) {
        newSelectedOrder = "chrono";
    }


    if(newSelectedCountry != 'Select Country' && newMinPrice != '' && newMaxPrice != '')
        request.open('get', siteRoot + '/advancedSearch?' + encodeForAjax({'searchField': searchFormInput.value, 'selectedRange': newSelectedRange, 'selectedCountry': newSelectedCountry, 'minPrice': newMinPrice, 'maxPrice': newMaxPrice, 'selectedOrder': newSelectedOrder}), true);
    else if(newSelectedCountry != 'Select Country' && newMinPrice == '' && newMaxPrice == '')
        request.open('get', siteRoot + '/advancedSearch?' + encodeForAjax({'searchField': searchFormInput.value, 'selectedRange': newSelectedRange, 'selectedCountry': newSelectedCountry, 'selectedOrder': newSelectedOrder}), true);
    else if(newSelectedCountry == 'Select Country' && newMinPrice != '' && newMaxPrice != '')
        request.open('get', siteRoot + '/advancedSearch?' + encodeForAjax({'searchField': searchFormInput.value, 'selectedRange': newSelectedRange, 'minPrice': newMinPrice, 'maxPrice': newMaxPrice, 'selectedOrder': newSelectedOrder}), true);
    else
        request.open('get', siteRoot + '/advancedSearch?' + encodeForAjax({'searchField': searchFormInput.value, 'selectedRange': newSelectedRange, 'selectedOrder': newSelectedOrder}), true);


    request.addEventListener('load', searchEventsReceived);
    request.send();

    event.preventDefault();
}

window.addEventListener("load", function() {

    searchEvent();

    event.preventDefault();
});

selectedRange.addEventListener("change", function() {

    searchEvent();

    event.preventDefault();
});

selectedCountry.addEventListener("change", function() {

    searchEvent();

    event.preventDefault();
});

minPrice.addEventListener("change", function() {

    searchEvent();

});

maxPrice.addEventListener("change", function() {

    searchEvent();

});

let selectedOrders = document.querySelectorAll('#selectedOrder [name="customRadio"]');
var prev = null;
for(var i = 0; i < selectedOrders.length; i++) {
    selectedOrders[i].onclick = function() {

        searchEvent();

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


    div1.append(div2);
    div2.append(div3);

    container.append(div1);

}

function encodeForAjax(data) {
    return Object.keys(data).map(function(k){
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&');
}