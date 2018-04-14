<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Event extends Model
{
    protected $primaryKey = 'idevent';
    protected $table = 'event';

    public function eventName(){
        return $this->name;
    }

}
