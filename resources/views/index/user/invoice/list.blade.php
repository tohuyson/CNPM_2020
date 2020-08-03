<?php
/**
 * Created by PhpStorm.
 * User: Loc Nguyen
 * Date: 10/18/2018 20:34
 */
?>
@extends("index.layout.index")
@section("content")
    <div class="contact-agile">
        <div class="faq">
            <h4 class="latest-text w3_latest_text">Danh sách hóa đơn</h4>
            <div class="container">
                <div class="col-md-12">
                    <!--Table-->
                    <table class="table table-striped w-auto">

                        <!--Table head-->
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>Ngày mua</th>
                            <th>Tổng cộng</th>
                            <th>Tổng cộng (USD)</th>
                            <th>Trạng thái thanh toán</th>
                            <th>Trạng thái vé</th>
                            <th>Chi tiết</th>
                        </tr>
                        </thead>
                        <!--Table head-->

                        <!--Table body-->
                        <tbody>
                        @foreach($invoices as $i => $detail)
                        <tr class="table-info">
                            <th scope="row">{{++$i}}</th>
                            <td>{{date_format(date_create($detail->buy_date),"d/m/Y")}}</td>
                            <td>{{number_format($detail->total)}} VND</td>
                            <td>{{number_format($detail->total_usd)}} USD</td>
                            <td>
                                @if ($detail->payment_id != 0)
                                    Đã thanh toán qua PAYPAL
                                @else
                                    Chưa thanh toán
                                @endif
                            </td>
                            <td>
                                @if ($detail->status == 1)
                                    Đã nhận vé
                                @else
                                    Chưa nhận vé
                                @endif
                            </td>
                            <td>
                                <a href="{{route('index.user.invoice.detail.get',['id'=>$detail->id])}}" class="btn btn-default">Xem đơn hàng</a>
                            </td>
                        </tr>
                        @endforeach
                        <!--Table body-->


                    </table>
                    <!--Table-->
                </div>
            </div>
        </div>
    </div>
@endsection