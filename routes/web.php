<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/


//index
//login
Route::get("login", "Auth\CustomerLoginController@Login")->name('index.login.get');
Route::post("login", "Auth\CustomerLoginController@postLogin")->name('index.login.post');


//logout
Route::get("logout", "Auth\CustomerLoginController@getLogout")->name('index.logout.get');
//register
Route::get("register", "Auth\CustomerLoginController@getRegister")->name('index.register.get');
Route::post("register", "Auth\CustomerLoginController@postRegister")->name('index.register.post');
Route::get("confirmRegister/{email}/{key}", 'CustomerLoginController@confirmRegister')->name("confirmRegister");


//home
Route::get('/', 'IndexHomeController@getHome')->name('index.home.get');
//movies
Route::get('getMovieByKey', 'IndexMovieController@getByKey')->name('index.movie.cs.get');
Route::get('coming_soon.html', 'IndexMovieController@getCSMovies')->name('index.movie.cs.get');
Route::get('now_showing.html', 'IndexMovieController@getNSMovies')->name('index.movie.ns.get');
// //detail movie
Route::get('movie/{id}/{slug}.html', 'IndexMovieController@getDetail')->name('index.movie.detail.get');

Route::get('auth/{provider}', 'Auth\CustomerLoginController@redirectToProvider');
//
Route::get('auth/{provider}/callback', 'Auth\CustomerLoginController@handleProviderCallback');

//admin

Route::get('/Admin/movieModel/list', 'Admin\MovieMng@displayListMovie');
Route::get('/edit/{id}', 'Admin\MovieMng@editMovie');
Route::get('/Admin/movieModel/add', function () {
    return view("Admin.form");
});
Route::post('/Admin/movieModel/add', 'Admin\MovieMng@addNewMovie')->name('/Admin/movieModel/add');

Route::post('/updateMovie/{id}', 'Admin\MovieMng@updateMovie')->name('updateMovie');

Route::post('/deleteMovie/{id}', 'Admin\MovieMng@deleteMovie')->name('deleteMovie');