<div class="modal fade" id="modalInvite" tabindex="-1" role="dialog" aria-labelledby="modalInviteTitle"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <form method="POST" action="{{route('inviteEvent', $event)}}" class="modal-content">
            {{ csrf_field()}}
            <div class="modal-header">
                <h5 class="modal-title" id="modalInviteTitle">Invite people</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="text" name="usernameField" id="usernameField" placeholder="Input username..."/>
                <!--<input type="button" name="search_button" id="search_button">-->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary">Send invite</button>
            </div>
        </form>
    </div>
</div>

<div class="modal fade" id="modalBuyTicket" tabindex="-1" role="dialog" aria-labelledby="modalBuyTicket"
     aria-hidden="true">
    <div class="modal-dialog" role="document" id="ticketTypeBody">

        <div class="modal-content">
            {{ csrf_field()}}
            <div class="modal-header">
                <h5 class="modal-title" id="modalInviteTitle">{{$event->name}}'s Tickets</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" style="cursor: pointer;" >
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