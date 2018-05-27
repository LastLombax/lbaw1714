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

buyTicketBt.onclick = function(event){
    let ticketId = document.querySelector('#selectedTicketType .ticketType').getAttribute('id');
    let ticketQuantity = getSelectedOption(document.getElementById('ticketQuantity'));
    let taxNumber = document.querySelector('#taxNumber').value;
    let invoiceName = document.querySelector('#invoiceName').value;
    let invoiceAddress = document.querySelector('#invoiceAddress').value;
    event.preventDefault();


    if(ticketQuantity != "none"){
        let request = new XMLHttpRequest();

        request.open('POST', siteRoot + '/buyTicket', true);

        request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);
        request.setRequestHeader("Content-type", "application/json");

        request.addEventListener('load', recievedTickets);

        let data = {'ticketTypeId': ticketId, 'nrOfTickets': ticketQuantity, 'taxNumber': taxNumber, 'invoiceName':invoiceName, 'invoiceAddress': invoiceAddress};
        request.send(JSON.stringify(data));
    }

};

function recievedTickets(){
    let lines = JSON.parse(this.responseText);

    if(lines){
        let buyTicketBody = document.querySelector('#modalBuyTicket');

        buyTicketBody.innerHTML = "" +
            "<div class=\"card text-white bg-success mb-3\" style=\"width: 100%; margin:0px !important;\">\n" +
            "  <div class=\"card-body\">\n" +
            "    <h4 class=\"card-title\">Ticket Purchase</h4>\n" +
            "    <p class=\"card-text\">Your ticket was successfully purchased! Thank you! You can get you invoice at your profile page.</p>\n" +
            "  </div>" +
            "</div>";
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