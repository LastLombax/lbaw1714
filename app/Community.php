<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;


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

    public function imagePath(){
		if($this->imagepath == null)
            return Storage::url('img/community/unknown.png');
		else
			return Storage::url($this->imagepath);
	}


    public function printDate(){
        $creationDate = strtotime($this->creationdate);
        echo date('F d, Y', $creationDate);
    }

}
