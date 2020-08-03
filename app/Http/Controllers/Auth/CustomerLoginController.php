<?php

namespace App\Http\Controllers\auth;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;

class CustomerLoginController extends Controller
{
    //
    public function Login() {
        return view("index.auth.login");
    }

    public function postLogin(Request $request) {
        if (Auth::attempt(['email' => $request->email, 'password' => $request->password])) {
            return redirect()->route("index.home.get");
        } else {
            return redirect()->route('index.login.get');
        }
    }

    public function getLogout() {
        Auth::logout();
        return redirect()->back();
    }

    public function getRegister() {
        return view("index.auth.register");
    }

    public function postRegister() {
        //
    }
}
