<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Invoice extends Model
{
    public $timestamps  = false;

    protected $primaryKey = 'idinvoice';
    protected $table = 'invoice';

    /*public function ticketTypes(){
        return $this->hasMany('App\TicketType', 'idmember');
    }*/
}
