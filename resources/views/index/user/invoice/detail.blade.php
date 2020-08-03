@extends("index.layout.index")
@section("style")
    <style>
        .ticket {
            background-color: rgb(58,58,58);
            -webkit-border-radius: 20px;
            -moz-border-radius: 20px;
            border-radius: 20px;
            padding: 20px;
            color: white;
        }
        .ticket h3 {
            text-align: center;
            padding-bottom: 20px;
        }
        .ticket h4 {
            font-size: 1.3em;
            padding-bottom: 10px;
        }
    </style>
    <style>
        @import url('https://fonts.googleapis.com/css?family=Pacifico');
        h4, span, h3 {
            font-family: 'Pacifico', cursive;
        }
    </style>
@endsection
@section("content")
    <div class="contact-agile">
        <div class="faq">
            <h4 class="latest-text w3_latest_text">Chi tiết hóa đơn</h4>
            <div class="container">
                <div class="col-md-offset-2 col-md-8 ticket">
                    {{--<div class="icon-w3">--}}
                        {{--<span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>--}}
                    {{--</div>--}}
                    <h3>Invoice</h3>
                    <div class="row">
                        <div class="col-md-2">
                            <img src="{{$plan_cinema->movie_image}}" class="img-rounded img-thumbnail img-responsive" width="150px">
                        </div>
                        <div class="col-md-5">
                            <h4 style="font-family: 'Pacifico', cursive;">Mã HD: {{\App\Http\Controllers\CustomerController::ConvertIdInvoice($invoice->id)}}</h4>
                            <h4>Phim: {{$plan_cinema->movie_name}}</h4>
                            <h4>Rạp: {{$plan_cinema->cinema_name}}</h4>
                            <h4>Phòng: {{$plan_cinema->room_name}}</h4>
                            <h4>Ngày chiếu: {{date_format(date_create($plan_cinema->show_date),"d/m/Y")}}</h4>
                            <h4>Suất chiếu: <span style="font-size: 1.3em">{{date_format(date_create($plan_cinema->time_begin),"H:i")}}</span></h4>
                            <h4>Ghế:
                                @foreach($tickets as $detail)
                                    {{\App\Plan_cinema::getSeatRowCol($detail->seat_id)}},
                                @endforeach
                            </h4>
                        </div>
                        <div class="col-md-5">
                            <h4>Combo: </h4>
                            @if ($products)
                            @foreach($products as $detail)
                                <hr/>
                                <h4 style="padding-left: 30px">{{$detail->product->name}}</h4>
                                <h4 style="padding-left: 30px">SL: {{$detail->qty}} - Giá: {{number_format($detail->price)}} VNĐ</h4>
                            @endforeach
                                @endif
                        </div>
                        <div class="col-md-12">
                            <hr/>
                            <h4>Tổng: {{number_format($invoice->total)}} VNĐ</h4>
                        </div>
                        <div class="col-md-12">
                            <h4 style="text-align: right">Trạng thái: đã thanh toán -
                                @if ($invoice->status == 1)
                                    đã nhận
                                @else
                                    chưa nhận
                                @endif
                            </h4>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
@endsection