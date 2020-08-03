<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Invoice_detail extends Model
{
    //
    protected $table = "invoice_details";

    public function product() {
        return $this->belongsTo('App\Product','product_id','id');
    }
}
