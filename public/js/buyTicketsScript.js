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

    let request = new XMLHttpRequest();
    request.open('get', siteRoot + '/buyTicket?' + encodeForAjax({'id': ticketId}), true);
    request.addEventListener('load', recievedTickets);
    //request.send();
};

function searchEventsReceived(){
    let lines = JSON.parse(this.responseText);
}

function encodeForAjax(data) {
    return Object.keys(data).map(function(k){
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&');
}