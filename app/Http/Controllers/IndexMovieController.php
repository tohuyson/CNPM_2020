<?php

namespace App\Http\Controllers;

use App\Movie;
use App\SP;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Input;
class IndexMovieController extends Controller
{
    //
    public function getNSMovies() {
        $ns_movies = SP::getNSMovies();
        return view('index.movie.now_showing',compact('ns_movies'));
    }
    public function getByKey() {
        $keywork = Input::get('key');
        $ns_movies = SP::getByKey($keywork);
        return view('index.movie.now_showing',compact('ns_movies'));
        
    }

    public function getCSMovies() {
        $cs_movies = SP::getCSMovies();
        return view('index.movie.coming_soon',compact('cs_movies'));
    }

    public function getDetail($id, $slug) {
        $movie = Movie::find($id);
        return view('index.movie.detail',compact('movie'));
    }
}
