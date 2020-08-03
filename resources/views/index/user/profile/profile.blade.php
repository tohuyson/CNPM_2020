<?php
/**
 * Created by PhpStorm.
 * User: Loc Nguyen
 * Date: 10/18/2018 20:34
 */
?>
@extends("index.layout.index")
@section("content")
    @if (count($errors) > 0 || session('error'))
        <div class="alert alert-danger" role="alert">
            <strong>Cảnh báo!</strong><br>
            @foreach($errors->all() as $err)
                {{$err}}<br/>
            @endforeach
            {{session('error')}}
        </div>
    @endif
    @if (session('success'))
        <div class="alert alert-success">
            <strong>Thành công!</strong>
            <button type="button" class="close" data-dismiss="alert">×</button>
            <br/>
            {!! session('success')!!}
        </div>
    @endif
    {{--<div class="contact-agile">--}}
    <h4 class="latest-text w3_latest_text">Thông tin người dùng</h4>
    <div class="container" style="margin-bottom: 30px">
        <div class="col-md-4">
            <form class="">
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" class="form-control" name="email" value="{{old("email",$CustomerLogin->email)}}"
                           placeholder="Email">
                </div>
                <div class="form-group">
                    <label>Họ & tên</label>
                    <input type="text" class="form-control" name="name" value="{{old("name",$CustomerLogin->name)}}"
                           placeholder="Họ & tên">
                </div>
                <div class="form-group">
                    <label>Số điện thoại</label>
                    <input type="tel" class="form-control" name="phone" value="{{old("phone",$CustomerLogin->phone)}}"
                           placeholder="Số điện thoại">
                </div>
                <div class="form-group">
                    <label>Căn cước/CMND</label>
                    <input type="number" class="form-control" name="id_card_number" value="{{old("id_card_number",$CustomerLogin->id_card_number)}}"
                           placeholder="Căn cước/CMND">
                </div>
                <div class="form-group">
                    <label>Ngày sinh</label>
                    <input type="date" class="form-control" name="birthday"
                           value="{{old("birthday",$CustomerLogin->birthday)}}" placeholder="Ngày sinh">
                </div>
                <div class="form-group">
                    <label>Giới tính</label>
                    <select class="form-control" name="sex">
                        <option value="1"
                                @if ($CustomerLogin->sex == 1)
                                selected
                                @endif
                        >Nam
                        </option>
                        <option value="2"
                                @if ($CustomerLogin->sex == 2)
                                selected
                                @endif
                        >Nữ
                        </option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Tỉnh</label>
                    <select class="form-control" name="province">
                        @if ($provinces)
                            @foreach($provinces as $detail)
                                <option value="{{$detail->id}}"
                                    @if ($detail->id == $CustomerLogin->province)
                                        selected
                                    @endif
                                >{{$detail->name}}</option>
                            @endforeach
                        @endif
                        <option>1</option>
                        <option>2</option>
                        <option>3</option>
                        <option>4</option>
                        <option>5</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Địa chỉ</label>
                    <input type="text" class="form-control" name="address"
                           value="{{old("address",$CustomerLogin->address)}}" placeholder="Địa chỉ">
                </div>
                <button type="submit" class="btn btn-primary">Lưu thông tin</button>
            </form>
        </div>
        <div class="col-md-4">
            <form>
                <div class="form-group">
                    <label>Mật khẩu hiện hành</label>
                    <input type="password" class="form-control" placeholder="Mật khẩu hiện hành">
                </div>
                <div class="form-group">
                    <label>Mật khẩu mới</label>
                    <input type="password" class="form-control" placeholder="Mật khẩu mới">
                </div>
                <div class="form-group">
                    <label>Nhập lại mật khẩu mới</label>
                    <input type="password" class="form-control" placeholder="Nhập lại mật khẩu mới">
                </div>
                <button type="submit" class="btn btn-primary">Đổi mật khẩu</button>
            </form>
        </div>
        <div class="col-md-4">
            <table class="table table-striped w-auto">
                <!--Table body-->
                <tbody>
                <tr class="table-info">
                    <th>Số thẻ thành viên</th>
                    <td>
                        <?php $member = "";
                        for ($i = 0; $i < strlen($CustomerLogin->id_card_member); $i++)
                            if (($i+1) % 4 == 0)
                                $member .= $CustomerLogin->id_card_member[$i] . " ";
                            else
                                $member .= $CustomerLogin->id_card_member[$i]
                        ?>
                        {{$member}}
                    </td>
                </tr>
                <tr class="table-info">
                    <th>Tổng chi tiêu 2018</th>
                    <td>99,999,999 VND</td>
                </tr>
                <tr class="table-info">
                    <th>Điểm tích lũy</th>
                    <td>15 Điểm</td>
                </tr>
                <!--Table body-->
            </table>
        </div>
    </div>
    {{--</div>--}}
@endsection