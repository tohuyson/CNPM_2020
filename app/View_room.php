<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class View_room extends Model
{
    //
    protected $table = "view_rooms";

    public function room()
    {
        return $this->hasMany('App\Room','view','id');
    }
}
