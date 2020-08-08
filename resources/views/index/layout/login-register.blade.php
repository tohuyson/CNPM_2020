<div class="modal video-modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                Đăng nhập & đăng ký
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
            </div>
            <section>
                <div class="modal-body">
                    <div class="w3_login_module">
                        <div class="module form-module">
                            <div class="toggle">
                                <i class="fa fa-times fa-pencil"></i>
                                <div class="tooltip">Click Me</div>
                            </div>
                            <div class="form">
                                <h3>Đăng nhập</h3>
                                <form action="{{route('index.login.post')}}" method="post">
                                    {{csrf_field()}}
                                    <input type="email" name="email" placeholder="Email" required="">
                                    <input type="password" name="password" placeholder="Password" required="">
                                    <input type="submit" value="Đăng nhập">
                                    <div class="com-sm-12">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <p class="text-center">
                                                    <a href="auth/google" style="background-color:red;color:white;"
                                                       class="google btn mybtn"><i class="fa fa-google">
                                                        </i>oogle
                                                    </a>
                                                </p>
                                            </div>
                                            <div class="col-sm-6">
                                                <p class="text-center">
                                                    <a href="auth/facebook" style="background-color:#0069d9;color:white;"
                                                       class="google btn mybtn"><i class="fa fa-facebook">
                                                        </i>acebook
                                                    </a>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="form">
                                <h3>Tạo tài khoản</h3>
                                <form action="#" method="post">
                                    <input type="text" name="Username" placeholder="Username" required="">
                                    <input type="password" name="Password" placeholder="Password" required="">
                                    <input type="email" name="Email" placeholder="Email Address" required="">
                                    <input type="text" name="Phone" placeholder="Phone Number" required="">
                                    <input type="submit" value="Đăng ký">
                                </form>
                            </div>
                            <div class="cta"><a href="#">Quên mật khẩu?</a></div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>
<script>
    $('.toggle').click(function () {
        // Switches the Icon
        $(this).children('i').toggleClass('fa-pencil');
        // Switches the forms
        $('.form').animate({
            height: "toggle",
            'padding-top': 'toggle',
            'padding-bottom': 'toggle',
            opacity: "toggle"
        }, "slow");
    });
</script>