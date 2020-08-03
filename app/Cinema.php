<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Cinema extends Model
{
    //
    protected $table = "cinemas";

    public function room() {
        return $this->hasMany('App\Room', 'cinema_id', 'id');
    }

    public function province() {
        return $this->belongsTo("App\Province","province_id","id");
    }
}
