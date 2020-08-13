<html lang="en" class="full-height">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Đăng ký tài khoản</title>
    <base href="{{asset("")}}">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- Bootstrap core CSS -->
    <link href="asset/index/md/css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="asset/index/md/css/mdb.min.css" rel="stylesheet">
    <!-- Your custom styles (optional) -->
    <link href="asset/index/md/css/style.css" rel="stylesheet">

    <style>
        .form-elegant .font-small {
            font-size: 0.8rem;
        }

        .form-elegant .z-depth-1a {
            -webkit-box-shadow: 0 2px 5px 0 rgba(55, 161, 255, 0.26), 0 4px 12px 0 rgba(121, 155, 254, 0.25);
            box-shadow: 0 2px 5px 0 rgba(55, 161, 255, 0.26), 0 4px 12px 0 rgba(121, 155, 254, 0.25);
        }

        .form-elegant .z-depth-1-half,
        .form-elegant .btn:hover {
            -webkit-box-shadow: 0 5px 11px 0 rgba(85, 182, 255, 0.28), 0 4px 15px 0 rgba(36, 133, 255, 0.15);
            box-shadow: 0 5px 11px 0 rgba(85, 182, 255, 0.28), 0 4px 15px 0 rgba(36, 133, 255, 0.15);
        }
    </style>
</head>
<body>
<div style="height: 100vh; display: flex; align-items: center;">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <section class="form-elegant">

                    <!--Form without header-->
                    <div class="card">
                        <div class="card-body">

                            <!--Header-->
                            <div class="text-center">
                                <h3 class="dark-grey-text mb-5"><strong>ĐĂNG KÝ</strong></h3>
                            </div>
                            <form action="{{route('index.register.post')}}" method="post">
                                {{csrf_field()}}
                                @if(session('mess'))
                                    <div class="alert alert-danger" role="alert" style="font-size: 13px">
                                        {{session('mess')}}
                                    </div>
                                @endif
                                <div class="row">
                                    <div class="col-md-6">
{{--                                    {{csrf_field()}}--}}
                                    <!--Body-->
                                        <div class="md-form">
                                            <input type="text" name="name" class="form-control"required>
                                            <label>Your name</label>
                                        </div>

                                        <div class="md-form">
                                            <input type="email" name="email" class="form-control"required>
                                            <label>Your email</label>
                                        </div>

                                        <div class="form-group">
                                            {{--<md-input-container>--}}
                                            <label>Your Birthday</label>
                                            <input type="date" name="birthday" class="form-control"required>
                                            {{--</md-input-container>--}}
                                        </div>

                                        <div class="md-form">
                                            <input type="password" name="password" class="form-control"required>
                                            <label>Your password</label>
                                        </div>

                                        <div class="md-form pb-3">
                                            <input type="password" name="re_password" class="form-control"required>
                                            <label>Confirm your password</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                    {{--                                        <form action="{{route('index.register.post')}}" method="post">--}}
                                    <!--Body-->
                                        <div class="md-form">
                                            <input type="tel" name="phone" class="form-control"required>
                                            <label>Your phone</label>
                                        </div>

                                        <div class="form-group">
                                            <label >Province</label>
                                            <select class="form-control" name="province">
                                                <option>An Giang</option>
                                                <option>Bà Rịa – Vũng Tàu</option>
                                                <option>Bắc Giang</option>
                                                <option>Bắc Kạn</option>
                                                <option>Bạc Liêu</option>
                                                <option>Bắc Ninh</option>
                                                <option>Bến Tre</option>
                                                <option>Bình Định</option>
                                                <option>Bình Dương</option>
                                                <option>Bình Phước</option>
                                                <option>Bình Thuận</option>
                                                <option>Cà Mau</option>
                                                <option>Cần Thơ</option>
                                                <option>Cao Bằng</option>
                                                <option>Đà Nẵng</option>
                                                <option>Đắk Lắk</option>
                                                <option>Đắk Nông</option>
                                                <option>Điện Biên</option>
                                                <option>Đồng Nai</option>
                                                <option>Đồng Tháp</option>
                                                <option>Gia Lai</option>
                                                <option>Hà Giang</option>
                                                <option>Hà Nam</option>
                                                <option>Hà Nội</option>
                                                <option>Hà Tĩnh</option>
                                                <option>Hải Dương</option>
                                                <option>Hải Phòng</option>
                                                <option>Hậu Giang</option>
                                                <option>Hòa Bình</option>
                                                <option>Hưng Yên</option>
                                                <option>Khánh Hòa</option>
                                                <option>Kiên Giang</option>
                                                <option>Kon Tum</option>
                                                <option>Lai Châu</option>
                                                <option>Lâm Đồng</option>
                                                <option>Lạng Sơn</option>
                                                <option>Lào Cai</option>
                                                <option>Long An</option>
                                                <option>Nam Định</option>
                                                <option>Nghệ An</option>
                                                <option>Ninh Bình</option>
                                                <option>Ninh Thuận</option>
                                                <option>Phú Thọ</option>
                                                <option>Phú Yên</option>
                                                <option>Quảng Bình</option>
                                                <option>Quảng Nam</option>
                                                <option>Quảng Ngãi</option>
                                                <option>Quảng Ninh</option>
                                                <option>Quảng Trị</option>
                                                <option>Sóc Trăng</option>
                                                <option>Sơn La</option>
                                                <option>Tây Ninh</option>
                                                <option>Thái Bình</option>
                                                <option>Thái Nguyên</option>
                                                <option>Thanh Hóa</option>
                                                <option>Thừa Thiên Huế</option>
                                                <option>Tiền Giang</option>
                                                <option>Thành phố Hồ Chí Minh</option>
                                                <option>Trà Vinh</option>
                                                <option>Tuyên Quang</option>
                                                <option>Vĩnh Long</option>
                                                <option>Vĩnh Phúc</option>
                                                <option>Yên Bái</option>
                                            </select>
                                        </div>

                                        <div class="md-form">
                                            <input type="text" name="address" class="form-control"required>
                                            <label>Address</label>
                                        </div>

                                        <div class="md-form">
                                            <input type="password" name="id_card_number" class="form-control"required>
                                            <label>Your No.Card</label>
                                        </div>

                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="sex"
                                                   id="exampleRadios1" value="1" checked>
                                            <label class="form-check-label" for="exampleRadios1">
                                                Nam
                                            </label><br>
                                            <input class="form-check-input" type="radio" name="sex"
                                                   id="exampleRadios2" value="2">
                                            <label class="form-check-label" for="exampleRadios2">
                                                Nữ
                                            </label>
                                        </div>
                                        {{--</form>--}}
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4"></div>
                                    <div class="col-md-4">
                                        <div class="text-center mb-3">
                                            <button type="submit" name="register"
                                                    class="btn blue-gradient btn-block btn-rounded z-depth-1a">
                                                ĐĂNG KÝ
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!--Footer-->
                        <div class="modal-footer mx-5 pt-3 mb-1">
                            <p class="font-small grey-text d-flex justify-content-end">Đã có tài khoản? <a
                                        href="{{route("index.login.get")}}"
                                        class="blue-text ml-1">
                                    Đăng nhập ngay</a></p>
                        </div>

                    </div>
                    <!--/Form without header-->

                </section>
            </div>
        </div>
    </div>
</div>

<!-- SCRIPTS -->
<!-- JQuery -->
<script type="text/javascript" src="asset/index/md/js/jquery-3.3.1.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="asset/index/md/js/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="asset/index/md/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="asset/index/md/js/mdb.min.js"></script>

</body>
</html>