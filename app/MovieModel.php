<?php


namespace App;


use Illuminate\Database\Eloquent\Model;

class MovieModel extends Model
{
    protected $table = "movies";
//    protected $primaryKey="id";
    public $timestamps=false;
}
