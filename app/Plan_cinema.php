<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Plan_cinema extends Model
{
    //
    protected $table = "plan_cinemas";

    public function type_projector()
    {
        return $this->belongsTo('App\Type_projector','type_projector_id','id');
    }

    public function room() {
        return $this->belongsTo('App\Room','room_id', 'id');
    }

    public function movie() {
        return $this->belongsTo('App\Movie','movie_id','id');
    }

    public static function getCinemaGroupBy($movie_id, $proj_id, $date) {
        $cinemas = DB::select("CALL `get_cinema_with_plan`($movie_id, $proj_id, '$date')");
        return $cinemas;
    }

    public static function GetHello() {
        $Name = "loc";
        return DB::select("CALL `HelloWorld`('{$Name}')",[]);
    }

    public static function GetSeatNone($plan_id) {
        $result = DB::select("CALL `get_seat_none`(?)",array($plan_id));
        return $result[0]->seat;
    }

    public static function getSeatsBookedByPlan($plan_id) {
        return DB::select("CALL `get_seats_booked_by_plan`(?)",$plan_id);
    }

    public static function getIDSeat($row, $col, $room_id) {
        $seat = Seat::where('room_id',$room_id)->where('row_name',$row)->where('col_name',$col)->first();
        return $seat->id;
    }

    public static function getSeatRowCol($id) {
        $seat = Seat::where('id',$id)->first();
        return $seat->row_name . "_" . $seat->col_name;
    }
}
