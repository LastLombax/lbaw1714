<?php
$i = 0;
foreach($event->ticketTypes as $ticketType){
    $i++;

        if($i == 1){
            if($ticketType->availablequantity > 0)
                echo '<div class="list-group">
                        <div class="list-group-item list-group-item-action flex-column align-items-start" id="selectedTicketType" style="border:none;">
                            <table style="width: 100%; text-align: center; padding: 5px;">
                                <tr>
                                    <td style="width: 70px; font-size: 70px;" class="ticketType" id="'.$ticketType->idtickettype.'">
                                        <i class="fas fa-ticket-alt"></i>
                                    </td>
                                    <td>
                                        <h6>'.$ticketType->description .'</h6>
                                    </td>
                                    <td>
                                        <h6>'. $ticketType->price.'€</h6>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>';
        }
        else{
            if($ticketType->availablequantity > 0)
                echo '<div class="list-group">
                        <div class="list-group-item list-group-item-action flex-column align-items-start" id="notSelectedTicketType" style="border:none;">
                            <table style="width: 100%; text-align: center; padding: 5px;">
                                <tr>
                                    <td style="width: 70px; font-size: 70px;" class="ticketType" id="'.$ticketType->idtickettype.'">
                                        <i class="fas fa-ticket-alt"></i>
                                    </td>
                                    <td>
                                        <h6>'.$ticketType->description .'</h6>
                                    </td>
                                    <td>
                                        <h6>'. $ticketType->price.'€</h6>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>';
        }
}