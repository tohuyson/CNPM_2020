@extends("index.layout.index")
@section("jquery")
    <script type="text/javascript" src="asset/index/other/js/jquery-2.1.4.min.js"></script>
@endsection
@section("content")
    <div id="slidey" style="display:none;">
        <ul>
            @foreach($banners as $detail)
                {{--<li><img src="{{$detail->image}}" alt=" "><p class='title'>Tarzan</p><p class='description'> Tarzan, having acclimated to life in London, is called back to his former home in the jungle to investigate the activities at a mining encampment.</p></li>--}}
                <li><img src="{{$detail->image}}" alt=" ">
                    <p class='description'>{{$detail->name}}</p></li>
            @endforeach
        </ul>
    </div>
    <script src="asset/index/other/js/jquery.slidey.js"></script>
    <script src="asset/index/other/js/jquery.dotdotdot.min.js"></script>
    <script type="text/javascript">
        $("#slidey").slidey({
            interval: 8000,
            listCount: 5,
            autoplay: false,
            showList: true
        });
        $(".slidey-list-description").dotdotdot();
    </script>
    <!-- //banner -->
    <!-- banner-bottom -->
    <div class="banner-bottom">
        <h4 class="latest-text w3_latest_text">Movie Selection</h4>
        <div class="container">
            <div class="w3_agile_banner_bottom_grid">
                <div id="owl-demo" class="owl-carousel owl-theme">
                    @foreach($movie_selections as $detail)
                        <div class="item">
                            <div class="w3l-movie-gride-agile w3l-movie-gride-agile1">
                                <a href="{{route("index.movie.detail.get",['id'=>$detail->id,'slug'=>$detail->slug_name])}}"
                                   class="hvr-shutter-out-horizontal"><img src="{{$detail->image}}" title="album-name"
                                                                           class="img-responsive" alt=" "/>
                                    <div class="w3l-action-icon"><i class="fa fa-play-circle" aria-hidden="true"></i>
                                    </div>
                                </a>
                                <div class="mid-1 agileits_w3layouts_mid_1_home">
                                    <div class="w3l-movie-text">
                                        <h6>
                                            <a href="{{route("index.movie.detail.get",['id'=>$detail->id,'slug'=>$detail->slug_name])}}">{{$detail->name}}</a>
                                        </h6>
                                    </div>
                                    <div class="mid-2 agile_mid_2_home" style="text-align: left">
                                        <p><strong>Thể loại:</strong> {{$detail->genre}}</p>
                                        <p><strong>Thời lượng:</strong> {{$detail->duration}} phút</p>
                                        <p><strong>Khởi
                                                chiếu:</strong> {{date_format(date_create($detail->release_date),"d-m-Y")}}
                                        </p>
                                        {{--<div class="block-stars">--}}
                                        {{--<ul class="w3l-ratings">--}}
                                        {{--<li><a href="#"><i class="fa fa-star" aria-hidden="true"></i></a></li>--}}
                                        {{--<li><a href="#"><i class="fa fa-star" aria-hidden="true"></i></a></li>--}}
                                        {{--<li><a href="#"><i class="fa fa-star" aria-hidden="true"></i></a></li>--}}
                                        {{--<li><a href="#"><i class="fa fa-star" aria-hidden="true"></i></a></li>--}}
                                        {{--<li><a href="#"><i class="fa fa-star-half-o" aria-hidden="true"></i></a></li>--}}
                                        {{--</ul>--}}
                                        {{--</div>--}}
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                                <div class="ribben">
                                    @if ($detail->rated == 0)
                                        <img src="https://betacineplex.vn/Assets/Common/icons/films/p.png">
                                    @elseif ($detail->rated == 13)
                                        <img src="https://betacineplex.vn/Assets/Common/icons/films/c-13.png">
                                    @elseif ($detail->rated == 16)
                                        <img src="https://betacineplex.vn/Assets/Common/icons/films/c-16.png">
                                    @elseif ($detail->rated == 18)
                                        <img src="https://betacineplex.vn/Assets/Common/icons/films/c-18.png">
                                    @endif
                                </div>
                            </div>
                        </div>
                    @endforeach
                </div>
            </div>
        </div>
    </div>
@endsection