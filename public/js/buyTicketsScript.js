let siteRoot2 = document.location.origin; //"http://localhost:8000/"
let ticketTypes = document.querySelectorAll('#notSelectedTicketType');
let selectedTicket = document.querySelector('#selectedTicketType');
let buyTicketBt = document.querySelector('#buyTicket');
selectedTicket.setAttribute("style", "background-color:#eee;");

ticketAnalyse();

function ticketAnalyse() {
    ticketTypes = document.querySelectorAll('#notSelectedTicketType');
    selectedTicket = document.querySelector('#selectedTicketType');
    selectedTicket.setAttribute("style", "background-color:#eee; border: 1px solid #ccc;");

    for(var i = 0; i < ticketTypes.length; i++) {
        ticketTypes[i].onclick = function(){

            selectedTicket.setAttribute("style", "border: none;");
            selectedTicket.setAttribute("id", "notSelectedTicketType");

            this.setAttribute("id", "selectedTicketType");
            this.setAttribute("style", "background-color:#eee; border: 1px solid #ccc;");


            ticketAnalyse();

        }.bind(ticketTypes[i]);
    }
}

buyTicketBt.onclick = function(){
    let ticketId = document.querySelector('#selectedTicketType .ticketType').getAttribute('id');
    let ticketQuantity = getSelectedOption(document.getElementById('ticketQuantity'));

    if(ticketQuantity != "none"){
        let request = new XMLHttpRequest();
        request.open('get', siteRoot2 + '/buyTicket?' + encodeForAjax({'id': ticketId, 'quantity': ticketQuantity}), true);
        request.addEventListener('load', recievedTickets);
        request.send();
    }

    event.preventDefault();
};

function recievedTickets(){
    let lines = JSON.parse(this.responseText);

    if(lines){
        let buyTicketBody = document.querySelector('#modalBuyTicket');

        buyTicketBody.innerHTML = "" +
            "<div class=\"card text-white bg-success mb-3\" style=\"width: 100%; margin:0px !important;\">\n" +
            "  <div class=\"card-body\">\n" +
            "    <h4 class=\"card-title\">Ticket Purchase</h4>\n" +
            "    <p class=\"card-text\">Your ticket was successfully purchased! Thank you!</p>\n" +
            "  </div>" +
            "</div>" +
            "<div style='height: 100%; width: 100%; background-color: #fff;''>" +
            "<div class='container' style='padding: 50px; text-align: center;'>" +
            "gvsdasvvhahsvssdajksvddjvdjlkjsdavjkdsvjkadsvjldsvdsvvasadjsvlk" +
            "</div>" +
            "</div>";
        disableScroll();
    }

}

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

var keys = {37: 1, 38: 1, 39: 1, 40: 1};

function preventDefault(e) {
    e = e || window.event;
    if (e.preventDefault)
        e.preventDefault();
    e.returnValue = false;
}

function preventDefaultForScrollKeys(e) {
    if (keys[e.keyCode]) {
        preventDefault(e);
        return false;
    }
}

function disableScroll() {
    if (window.addEventListener) // older FF
        window.addEventListener('DOMMouseScroll', preventDefault, false);
    window.onwheel = preventDefault; // modern standard
    window.onmousewheel = document.onmousewheel = preventDefault; // older browsers, IE
    window.ontouchmove  = preventDefault; // mobile
    document.onkeydown  = preventDefaultForScrollKeys;
}

function encodeForAjax(data) {
    return Object.keys(data).map(function(k){
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&');
}