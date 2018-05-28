<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Community extends Model
{
    protected $primaryKey = 'idcommunity';
    protected $table = 'community';
    public $timestamps = false;

    //Relations
	
	public function members(){ //memberTuples
		return $this->belongsToMany('App\Member','community_member', 'idcommunity', 'idmember');
	}

    public function numMembers(){
        return count($this->members);
    }


    public function printDate(){
        $creationDate = strtotime($this->creationdate);
        echo date('F d, Y', $creationDate);
    }

}
