<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Community extends Model
{
    protected $primaryKey = 'idcommunity';
    protected $table = 'community';

    //Relations
	
	public function members(){ //memberTuples
		return $this->belongsToMany('App\Member','community_member', 'idcommunity', 'idmember');
	}

    public function printDate(){
        $creationDate = strtotime($this->creationDate);
        echo date('F d, Y', $creationDate);
    }

}
