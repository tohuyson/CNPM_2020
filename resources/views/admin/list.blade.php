@extends('admin.layouts.movie')
@section('content')
    <div class="content">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <ol class="breadcrumb">
                        <li>
                            <a href=""><i class="ti-home"></i></a>
                        </li>
                        <li class="active">
                            Danh sách phim
                        </li>
                    </ol>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <a href="{{asset("Admin/movieModel/add")}}">
                            <button class="ladda-button btn btn-default waves-effect waves-light"
                                    data-style="expand-right">
                                <span class="btn-label"><i class="fa fa-plus"></i></span>Thêm phim
                            </button>
                        </a>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-12">
                    <div class="card-box table-responsive">
                        <h4 class="m-t-0 header-title"><b>Danh sách phim</b></h4>
                        @if(session('success'))
                            <div class="alert alert-success" role="alert" style="font-size: 13px">
                                {{session('success')}}
                            </div>
                        @else
                            <div class="alert" role="alert" style="font-size: 13px">
                                {{session('error')}}
                            </div>
                        @endif

                        <div id="datatable-responsive_wrapper"
                             class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="dataTables_length" id="datatable-responsive_length"><label>Hiện
                                            <select name="datatable-responsive_length"
                                                    aria-controls="datatable-responsive" class="form-control input-sm">
                                                <option value="10">10</option>
                                                <option value="25">25</option>
                                                <option value="50">50</option>
                                                <option value="100">100</option>
                                            </select> dòng</label></div>
                                </div>
                                <div class="col-sm-6"></div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <table id="datatable-responsive"
                                           class="table table-striped table-bordered dt-responsive nowrap dataTable no-footer dtr-inline"
                                           cellspacing="0" width="100%" role="grid"
                                           aria-describedby="datatable-responsive_info" style="width: 100%;">
                                        <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Phim</th>
                                            <th>Ảnh</th>
                                            <th>Đạo diễn</th>
                                            <th>Thể loại</th>
                                            <th>Ngày khởi chiếu</th>
                                            <th>Thời lượng</th>
                                            <th>Active</th>
                                            <th>Hành động</th>
                                        </tr>
                                        </thead>

                                        <tbody>
                                        @foreach($movieAll as $row)
                                            <tr>
                                                <td>{{$row->id}}</td>
                                                <td>{{$row->name}}</td>
                                                <td>
                                                    <img width="100px"
                                                         src="{{$row->image}}"
                                                         class="img-rounded img-thumbnail img-responsive">
                                                </td>
                                                <td>{{$row->director}}</td>
                                                <td>{{$row->genre}}</td>
                                                <td>{{$row->release_date}}</td>
                                                <td>{{$row->duration}} phút</td>
                                                <td>
                                                    @if ($row->isActive==1)
                                                        <i class="far fa-check-circle" style="color: green"></i>
                                                    @else

                                                        <i class="fas fa-ban" style="color: red"></i>
                                                    @endif
                                                </td>
                                                <td style="display: flex">
                                                    <div style="margin-right: 0.5rem">
                                                        <a href="{{asset('/edit/'.$row->id)}}"
                                                           class="btn btn-icon waves-effect waves-light btn-warning"
                                                           title="Sửa"> <i class="fa fa-wrench"></i></a>
                                                    </div>
                                                    <form action="{{route('deleteMovie',$row->id)}}" method="post">
                                                        {{--                                                        @csrf--}}
                                                        {{csrf_field()}}
                                                        <button type="submit"
                                                                class="btn btn-icon waves-effect waves-light btn-warning"
                                                                title="xóa"><i class="far fa-trash-alt"></i>
                                                        </button>
                                                    </form>


                                                </td>
                                            </tr>
                                        @endforeach
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="dataTables_info" id="datatable-responsive_info" role="status"
                                         aria-live="polite">Hiện từ 1 đến 1 trong tổng 1 dòng
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="dataTables_paginate paging_simple_numbers"
                                         id="datatable-responsive_paginate">
                                        <ul class="pagination">
                                            <li class="paginate_button previous disabled"
                                                aria-controls="datatable-responsive" tabindex="0"
                                                id="datatable-responsive_previous"><a href="#">Trước</a></li>
                                            <li class="paginate_button active" aria-controls="datatable-responsive"
                                                tabindex="0"><a href="#">1</a></li>
                                            <li class="paginate_button next disabled"
                                                aria-controls="datatable-responsive" tabindex="0"
                                                id="datatable-responsive_next"><a href="#">Sau</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
