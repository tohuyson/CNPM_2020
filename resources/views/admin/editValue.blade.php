@extends('admin.layouts.movie')
@section('content')
    <div class="content">
        <div class="row">
            <div class="col-sm-12">
                <div class="card-box">
                    <h4 class="m-t-0 header-title"><b>Chỉnh sửa</b></h4>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="p-l-r-10">
{{--                                trả về dữ liệu của phim theo id--}}
                                <form action="{{route('updateMovie',$movie->id)}}" method="post">
                                    {{csrf_field()}}

                                    <div class="form-group">
                                        <label class="control-label">Tên phim</label>
                                        <input name="name" type="text" class="form-control" value="{{$movie->name}}"
                                               placeholder="Nhập tên phim...">
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Image (Link)</label>
                                        <input name="image" type="text" class="form-control" value="{{$movie->image}}">
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">Thời lượng (phút)</label>
                                        <input name="duration" type="number" class="form-control"
                                               value="{{$movie->duration}}">
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Link trailer (YouTube)</label>
                                        <input name="link_trailer" type="text" class="form-control"
                                               value="{{$movie->link_trailer}}">
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Đạo diễn</label>
                                        <input name="director" type="text" class="form-control"
                                               value="{{$movie->director}}">
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Diễn viên</label>
                                        <input name="cast" type="text" class="form-control" value="{{$movie->cast}}">
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Thể loại</label>
                                        <input name="genre" type="text" class="form-control" value="{{$movie->genre}}">
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Ngôn ngữ</label>
                                        <input name="language" type="text" class="form-control"
                                               value="{{$movie->language}}">
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Ngày khởi chiếu</label>
                                        <br/>
                                        <input class="input-small datepicker hasDatepicker" id="release_date"
                                               type="date"
                                               name="release_date" value="{{$movie->release_date}}">
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">Hiện thị ra trang chử</label>
                                        <br/>
                                        <select name="show_home">
                                            @if($movie->show_home==1){
                                            <option value="1">Hiển thị</option>
                                            <option value="0">Không hiển thị</option>
                                            }
                                            @else {
                                            <option value="0">Không hiển thị</option>
                                            <option value="1">Hiển thị</option>
                                            }
                                            @endif
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Nội dung tóm tắt</label>
                                        <textarea name="content_movie" id="content" cols="70"
                                                  rows="10">{{$movie->content}}</textarea>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">Active</label>
                                        <br/>
                                        <select name="isActive">
                                            @if($movie->isActive==1){
                                            <option value="1">Active</option>
                                            <option value="0">Non_active</option>
                                            }
                                            @else {
                                            <option value="0">Non_active</option>
                                            <option value="1">Active</option>
                                            }
                                            @endif
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <button type="submit" class="ladda-button btn btn-default"
                                                data-style="expand-right">
                                            Lưu lại
                                        </button>
                                        <a href="/Admin/movieModel/list"
                                           class="ladda-button btn btn-default"
                                           data-style="expand-right">
                                            Cancel
                                        </a>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
