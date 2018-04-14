<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Event extends Model
{
    protected $primaryKey = 'idevent';

    public function eventName(){
        return $this->name;
    }

}
