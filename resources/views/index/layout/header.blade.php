<div class="header">
    <div class="container">
        <div class="w3layouts_logo">
            <a href="{{route('index.home.get')}}"><h1>Cini<span>Movies</span></h1></a>
        </div>
        <div class="w3_search">
            <form action="/getMovieByKey" method="get">
                <input type="text" name="key" placeholder="Search" required="">
                <input type="submit" value="Go">
            </form>
        </div>
        <div class="w3l_sign_in_register">
            <ul>
                {{--<li><i class="fa fa-phone" aria-hidden="true"></i> (+000) 123 345 653</li>--}}
                @if ($CustomerLogin)
                    <li><a href="#">Chào {{$CustomerLogin->name}}</a></li>
                @else
                    <li><a href="#" data-toggle="modal" data-target="#myModal">Đăng nhập</a></li>
                @endif
            </ul>
        </div>
        <div class="clearfix"></div>
    </div>
</div>