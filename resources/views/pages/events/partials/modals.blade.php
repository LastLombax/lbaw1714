<div class="modal fade" id="modalInvite" tabindex="-1" role="dialog" aria-labelledby="modalInviteTitle"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <form class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalInviteTitle">Invite people</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <div class="form-group" style="width: 100%;">
                    <input class="form-control form-control-lg" id="usernameField" type="text"
                           placeholder="Input username..." id="inputLarge">
                </div>

                <div class="friendsBody" id="{{$event->idevent}}">

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </form>
    </div>
</div>

<div class="modal fade" id="modalBuyTicket" tabindex="-1" role="dialog" aria-labelledby="modalBuyTicket"
     aria-hidden="true">
    <div class="modal-dialog" role="document" id="ticketTypeBody">

        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalInviteTitle">{{$event->name}}'s Tickets</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" style="cursor: pointer;">
                @include('pages.events.partials.buyTickets')
                <div class="form-group">
                    <br>
                    <select class="custom-select" id="ticketQuantity" style="width: 100%;">
                        <option selected="" value="none">Select Quantity</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                    </select>
                    <br><br>
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Your Name/Company" id="invoiceName">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Your/Company Address" id="invoiceAddress">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Invoice Tax Number" id="taxNumber">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" id="buyTicket" class="btn btn-primary">Buy</button>
            </div>

        </div>
    </div>
</div>