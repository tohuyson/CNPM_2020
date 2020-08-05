<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\movieModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use phpDocumentor\Reflection\Types\This;

class MovieMng extends Controller
{
    public static function displayListMovie()
    {
        $movieAll = movieModel::where('isDelete', 0)->get();

        return view('Admin.list')->with('movieAll', $movieAll);
    }

    function addNewMovie(Request $request)
    {
        $movie = new movieModel();
        $movie->name = $request->input('name');
        $movie->image = $request->input('image');
        $movie->duration = $request->input('duration');
        $movie->link_trailer = $request->input('link_trailer');
        $movie->director = $request->input('director');
        $movie->cast = $request->input('cast');
        $movie->genre = $request->input('genre');
        $movie->language = $request->input('language');
        $movie->release_date = $request->input('release_date');
        $movie->content = $request->input('content_movie');
        $movie->isActive = $request->input('isActive');
        $movie->isDelete = 0;
        $movie->save();
//        redirect()->back()->with('success', 'dgsadgkh');
//        if ($movie->save()) {
//        redirect('Admin.list');
//        redirect('/Admin/movieModel/list')->a
//        } else {
//            redirect()->back()->with('error', 'ddi');
//        }
        return redirect('/Admin/movieModel/list')->with("success", "Bạn thêm phim thành công");
    }


//    public static function getValue(Request $request, $id)
//    {
////        dd($id);
////        $id = $request . route(edit, ['id' => $id]);
////        $movie = movieModel::where('id', $id)->get();
//        $movie = MovieModel::findOrFail($id);
////        return view("Admin.editValue",compact('id'));
////        return $movies;/
//        return view('Admin.editValue')->with(['movie', $movie]);
////        echo 'dsda';
//    }

//    function editMovie(Request $request, $id)
//    {
//        $id = $request . route(edit, ['id' => $id]);
////        $movie = movieModel::where('id', $id)->get();
//        echo $id;
//    }
    public function editMovie($id)
    {
        $movie = MovieModel::findOrFail($id);
        return view('Admin.editValue')->with('movie', $movie);
    }

    public function updateMovie(Request $request, $id)
    {
//        echo 'ạhsdjfnejf';
        $movie = MovieModel::find($id);
//        dd($movie);
        $movie->name = $request->input('name');
        $movie->image = $request->input('image');
        $movie->duration = $request->input('duration');
        $movie->link_trailer = $request->input('link_trailer');
        $movie->director = $request->input('director');
        $movie->cast = $request->input('cast');
        $movie->genre = $request->input('genre');
        $movie->language = $request->input('language');
        $movie->release_date = $request->input('release_date');
        $movie->content = $request->input('content_movie');
        $movie->isActive = $request->input('isActive');
        $movie->isDelete = 0;
        $movie->update();
        return redirect('/Admin/movieModel/list')->with("success", "Bạn update dữ liệu thành công");

    }


    public function deleteMovie(Request $request, $id)
    {
        $movie = MovieModel::findOrFail($id);
        $movie->isDelete = 1;
        $movie->update();
        return redirect('/Admin/movieModel/list')->with("success", "Bạn delete thành công");
    }
}
