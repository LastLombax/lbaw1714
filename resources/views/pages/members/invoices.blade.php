<?php

use App\Comment;
use App\Community;
use App\Event;
use App\Member;

$query = \App\Http\Controllers\MemberController::invoices();

foreach ($query as $invoice){


    echo '<div class="list-group" style="cursor:pointer;" onclick="window.open(\'invoice/' . $invoice->id .'\', \'_blank\' )">
            <div class="list-group-item list-group-item-action flex-column align-items-start">
                    <table style="width: 100%; text-align: right;">
                        <tr>
                            <td style="width: 100px;">
                                <a href="invoices/' . $invoice->id . '">
                                    <img src="'.Storage::url($invoice->image).'" style="width: 100px; height: 100px; object-fit: cover; float:left;">
                                </a>
                            </td>
                            <td>
                            <table style="width: 100%; margin: 10px;">
                                <tr>
                                    <td>
                                        <h5 style="text-align: left;">'.$invoice->name.'</h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h6 style="text-align: left;">'.$invoice->quantity.'x '.$invoice->description.'</h6>
                                    </td>
                                </tr>
                            </table>
                            </td>
                            <td style="width:100px;">
                                <h4 style="text-align: center;">'.$invoice->amount.'€</h4>
                            </td>
                        </tr>
                    </table>
            </div>
        </div>';

}

?>