<!--
author: W3layouts
author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE html>
<html lang="en">
<head>
    <title>One Movies an Entertainment Category Flat Bootstrap Responsive Website Template | Single :: w3layouts</title>
    <!-- for-mobile-apps -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="One Movies Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template,
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design"/>
    <base href="{{asset('')}}">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    {{--<script type="application/x-javascript"> addEventListener("load", function () {--}}
            {{--setTimeout(hideURLbar, 0);--}}
        {{--}, false);--}}

        {{--function hideURLbar() {--}}
            {{--window.scrollTo(0, 1);--}}
        {{--} </script>--}}
    <!-- //for-mobile-apps -->
    <link href="asset/index/other/css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="asset/index/other/css/style.css" rel="stylesheet" type="text/css" media="all"/>
    <link href="asset/index/other/css/medile.css" rel='stylesheet' type='text/css'/>
    <link href="asset/index/other/css/single.css" rel='stylesheet' type='text/css'/>
    <link rel="stylesheet" href="asset/index/other/css/contactstyle.css" type="text/css" media="all"/>
    <link rel="stylesheet" href="asset/index/other/css/faqstyle.css" type="text/css" media="all"/>
    <!-- news-css -->
    <link rel="stylesheet" href="asset/index/other/news-css/news.css" type="text/css" media="all"/>
    <!-- //news-css -->
    {{--banner--}}
    <link href="asset/index/other/css/jquery.slidey.min.css" rel="stylesheet">
    <!-- list-css -->
    <link rel="stylesheet" href="asset/index/other/list-css/list.css" type="text/css" media="all"/>
    <!-- //list-css -->
    <!-- pop-up -->
    <link href="asset/index/other/css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
    <!-- //pop-up -->
    <!-- font-awesome icons -->
    <link rel="stylesheet" href="asset/index/other/css/font-awesome.min.css"/>
    <!-- //font-awesome icons -->
    <!-- js -->
    @yield('jquery')
    <script type="text/javascript" src="asset/index/other/js/jquery-2.1.4.min.js"></script>
    <!-- //js -->
    <!--<link href='//fonts.googleapis.com/css?family=Roboto+Condensed:400,700italic,700,400italic,300italic,300' rel='stylesheet' type='text/css'>-->
    <!-- start-smoth-scrolling -->
    <script type="text/javascript" src="asset/index/other/js/move-top.js"></script>
    <script type="text/javascript" src="asset/index/other/js/easing.js"></script>
    <script type="text/javascript">
//        jQuery(document).ready(function ($) {
//            $(".scroll").click(function (event) {
//                event.preventDefault();
//                $('html,body').animate({scrollTop: $(this.hash).offset().top}, 1000);
//            });
//        });
    </script>
    <!-- start-smoth-scrolling -->
    <link href="asset/index/other/css/owl.carousel.css" rel="stylesheet" type="text/css" media="all">
    <script src="asset/index/other/js/owl.carousel.js"></script>
    <script>
        $(document).ready(function () {
            $("#owl-demo").owlCarousel({

                autoPlay: 3000, //Set AutoPlay to 3 seconds

                items: 5,
                itemsDesktop: [640, 5],
                itemsDesktopSmall: [414, 4]

            });

        });
    </script>
    {{--<script src="asset/index/other/js/simplePlayer.js"></script>--}}
    {{--<script>--}}
        {{--$("document").ready(function () {--}}
            {{--$("#video").simplePlayer();--}}
        {{--});--}}
    {{--</script>--}}
    <style>
        .pi-img-wrapper img {
            -webkit-border-radius: 20px;
            -moz-border-radius: 20px;
            border-radius: 20px;
        }
    </style>
    @yield("style")
</head>

<body>
<!-- header -->
@include('index.layout.header')
<!-- //header -->
<!-- bootstrap-pop-up -->
@include('index.layout.login-register')
<!-- //bootstrap-pop-up -->
<!-- nav -->
@include('index.layout.menu')
<!-- //nav -->
{{--content--}}
        @yield('content')
{{--end content--}}
<!-- pop-up-box -->
<!-- footer -->
@include('index.layout.footer')
<!-- //footer -->
<!-- Bootstrap Core JavaScript -->
<script src="asset/index/other/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function () {
        $(".dropdown").hover(
            function () {
                $('.dropdown-menu', this).stop(true, true).slideDown("fast");
                $(this).toggleClass('open');
            },
            function () {
                $('.dropdown-menu', this).stop(true, true).slideUp("fast");
                $(this).toggleClass('open');
            }
        );
    });
</script>
<!-- //Bootstrap Core JavaScript -->
<!-- here stars scrolling icon -->
<script type="text/javascript">
    $(document).ready(function () {
        /*
            var defaults = {
            containerID: 'toTop', // fading element id
            containerHoverID: 'toTopHover', // fading element hover id
            scrollSpeed: 1200,
            easingType: 'linear'
            };
        */

        $().UItoTop({easingType: 'easeOutQuart'});

    });
</script>
@yield("script")
<!-- //here ends scrolling icon -->
</body>
</html>