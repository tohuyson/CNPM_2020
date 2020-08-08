<?php

namespace App\Http\Controllers;

use App\Banner;
use App\Movie;
use App\NewsOffer;
use Illuminate\Http\Request;

class IndexHomeController extends Controller
{
    //
    public function getHome() {
        $banners = Banner::where('status',1)->get();
        $news_offers = NewsOffer::all();
        $movie_selections = Movie::where('show_home',1)->get();
        return view('index.home.home',compact('banners','news_offers','movie_selections'));
    }
}
