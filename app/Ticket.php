<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Ticket extends Model
{
    protected $primaryKey = 'idticket';
    protected $table = 'ticket';

    public function type(){
        return $this->hasOne('App\TicketType', 'idtickettype');
    }
}
