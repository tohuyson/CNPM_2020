<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    //
    protected $table = "products";
    /*
     * Return price product
     * @param int $id
     * @return int
    */
    public static function getPriceProductByID($id) {
        return Product::find($id)->price;
    }

    public function invoice_detail() {
        return $this->hasMany('App\Invoice_detail','product_id','id');
    }
}
