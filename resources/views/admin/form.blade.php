@extends('admin.layouts.movie')
@section('content')
    <div class="content">
        <div class="row">
            <div class="col-sm-12">
                <div class="card-box">
                    <h4 class="m-t-0 header-title"><b>Thêm phim</b></h4>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="p-l-r-10">
{{--                                trả về validate nếu người dùng nhập thiếu hoặc sai--}}
                                @if (count($errors) > 0)
                                    <div class="alert alert-danger">
                                        Thông tin đăng ký không đầy đủ, bạn cần chỉnh sửa như sau:
                                        <ul>
                                            @foreach ($errors->all() as $error)
                                                <li>{{ $error }}</li>
                                            @endforeach
                                        </ul>
                                    </div>
                                @endif

                                <form action="{{route('/Admin/movieModel/add')}}" method="post">
                                    {{csrf_field()}}
                                    <input type="hidden" name="id" value="" value="0">
                                    @if(session('success'))
                                        <div>{{session('success')}}</div>
                                    @endif

                                    <div class="form-group">
                                        <label class="control-label">Tên phim</label>
                                        <input name="name" type="text" class="form-control" value=""
                                               placeholder="Nhập tên phim...">
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Image (Link)</label>
                                        <input name="image" type="text" class="form-control" value="">
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Thời lượng (phút)</label>
                                        <input name="duration" type="number" class="form-control" value=""
                                        >
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Link trailer (YouTube)</label>
                                        <input name="link_trailer" type="text" class="form-control" value=""
                                        >
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Đạo diễn</label>
                                        <input name="director" type="text" class="form-control" value="">
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Diễn viên</label>
                                        <input name="cast" type="text" class="form-control" value="">
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Thể loại</label>
                                        <input name="genre" type="text" class="form-control" value="">
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Ngôn ngữ</label>
                                        <input name="language" type="text" class="form-control" value=""
                                        >
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Ngày khởi chiếu</label>
                                        <br/>
                                        <input class="input-small datepicker hasDatepicker" id="release_date"
                                               type="date"
                                               name="release_date" value="">
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Hiện thị ra trang chử</label>
                                        <br/>
                                        <select name="show_home">
                                            <option value="1">Hiển thị</option>
                                            <option value="0">Không hiển thị</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label class="control-label">Nội dung tóm tắt</label>
                                        <textarea name="content_movie" id="content" cols="70"
                                                  rows="10"></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">Active</label>
                                        <br/>
                                        <select name="isActive">
                                            <option value="1">Active</option>
                                            <option value="0">Non_active</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <button class="ladda-button btn btn-default" data-style="expand-right">
                                            Lưu lại
                                        </button>
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
