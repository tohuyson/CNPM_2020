<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Movie;
use Illuminate\Http\Request;
use Validator;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Support\Facades\DB;
use phpDocumentor\Reflection\Types\This;

class MovieMng extends Controller
{
//    Lấy tất cả dữ liệu của phim từ database lên
    public static function displayListMovie()
    {
        $movieAll = Movie::where('isDelete', 0)->get();

        return view('Admin.list')->with('movieAll', $movieAll);
    }

//  thêm phim mới xuống database
    function addNewMovie(Request $request)
    {
//        thực hiện validate dữ liệu
        $validate = Validator::make(
            $request->all(),
            [
                'name' => 'required',
                'image' => 'required',
                'duration' => 'required|numeric',
                'link_trailer' => 'required',
                'director' => 'required',
                'cast' => 'required',
                'genre' => 'required',
                'language' => 'required',
                'release_date' => 'required',
                'content' => 'nullable',
            ],
            [
                'name.required' => 'Bạn chưa nhập tên phim.',
                'image.required' => 'Bạn chưa có ảnh phim.',
                'duration.required' => 'Bạn chưa nhập thời lượng.',
                'duration.numeric' => 'Thời lượng phải là số (phút).',
                'link_trailer.required' => 'Bạn chưa nhập trailer.',
                'director.required' => 'Bạn chưa nhập tên đạo diễn.',
                'cast.required' => 'Bạn chưa nhập tên điễn viên.',
                'genre.required' => 'Bạn chưa nhập thể loại.',
                'language.required' => 'Bạn chưa nhập ngôn ngữ.',
                'release_date.required' => 'Bạn chưa chọn ngày khởi chiếu.',

            ]
        );

        if ($validate->fails()) {
            return View('Admin.form')->withErrors($validate);
//            return $validate->errors()->all();
        }
        $movie = new Movie();
//        lưu dữ liệu xuống database
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
        $movie->show_home = $request->input('show_home');
        $movie->isActive = $request->input('isActive');
        $movie->isDelete = 0;
        $movie->save();
        return redirect('/Admin/movieModel/list')->with("success", "Bạn thêm phim thành công");
    }

// chỉnh sửa phim
    public function editMovie($id)
    {
//        Tìm phim theo íd
        $movie = Movie::findOrFail($id);
        return view('Admin.editValue')->with('movie', $movie);
    }

//cập nhật thay đổi của phim
    public function updateMovie(Request $request, $id)
    {
//        tìm phim theo id
            $movie = Movie::find($id);
//        cập nhật dữ liệu mới vào database
            $movie->name = $request->input('name');
            $movie->image = $request->input('image');
            $movie->duration = $request->input('duration');
            $movie->link_trailer = $request->input('link_trailer');
            $movie->director = $request->input('director');
            $movie->cast = $request->input('cast');
            $movie->genre = $request->input('genre');
            $movie->language = $request->input('language');
            $movie->release_date = $request->input('release_date');
            $movie->show_home = $request->input('show_home');
            $movie->content = $request->input('content_movie');
            $movie->isActive = $request->input('isActive');
            $movie->isDelete = 0;
            $movie->update();
            return redirect('/Admin/movieModel/list')->with("success", "Bạn update dữ liệu thành công");
    }

//Xóa phim
    public function deleteMovie(Request $request, $id)
    {
//        xóa phim theo id
        $movie = Movie::findOrFail($id);
        $movie->isDelete = 1;
        $movie->update();
        return redirect('/Admin/movieModel/list')->with("success", "Bạn delete thành công");
    }
}
