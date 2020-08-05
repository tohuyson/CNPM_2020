<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Danh sách mẫu phòng chiếu</title>
    <link href="/css/scroller.bootstrap.min.css" rel="stylesheet" type="text/css"/>

    <link href="/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="/css/core.css" rel="stylesheet" type="text/css"/>
    <link href="/css/components.css" rel="stylesheet" type="text/css"/>
    <link href="/css/icons.css" rel="stylesheet" type="text/css"/>
    <link href="/css/pages.css" rel="stylesheet" type="text/css"/>
    <link href="/css/responsive.css" rel="stylesheet" type="text/css"/>
    <link href="/fonts/fontawesome/fontawesome-free-5.13.0-web/css/all.css" rel="stylesheet" type="text/css"/>

    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
</head>
<body class="fixed-left">
<div id="wrapper">
    <!--    header-->
@include("admin.layouts.header")
{{--<!-- menu-->--}}
@include("admin.layouts.menu")

<!--content-->
    <div class="content-page">
{{--        @include("Admin.list")--}}
{{--    @yield('content')--}}
    @yield('content')
    <!--footer-->

        @include("admin.layouts.footer")
    </div>
</div>
<script src="/js/jquery.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/detect.js"></script>
<script src="/js/fastclick.js"></script>
<script src="/js/jquery.slimscroll.js"></script>
<script src="/js/jquery.blockUI.js"></script>
<script src="/js/waves.js"></script>
<script src="/js/wow.min.js"></script>
<script src="/js/jquery.nicescroll.js"></script>
<script src="/js/jquery.scrollTo.min.js"></script>
<script src="/js/bootstrap-datepicker.js"></script>

<script src="/js/jquery.dataTables.min.js"></script>
<script src="/js/dataTables.bootstrap.js"></script>


<script type="text/javascript" src="/js/jquery.multi-select.js"></script>

<script src="/js/select2.js" type="text/javascript"></script>
{{--<script src="/js/bootstrap-select.js" type="text/javascript"></script>--}}
<script src="/js/bootstrap-filestyle.js" type="text/javascript"></script>


<script src="/js/datatables.init.js"></script>
<script type="text/javascript" src="/js/jquery.form-advanced.init.js"></script>

<script src="/js/jquery.peity.js"></script>

<script src="/js/jquery.core.js"></script>
<script src="/js/jquery.app.js"></script>

<script src="/js/jquery.confirm.js"></script>

<script src="/js/jquery.knob.js"></script>
</body>
</html>
