<?php

namespace App\Http\Controllers\auth;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class AdminLoginController extends Controller
{
    //
    public function login() {
        return view("Admin.auth.login");
    }

    public function postlogin(Request $request) {
        if (Auth::guard('Admin')->attempt(['email' => $request->email, 'password' => $request->password])) {
            return redirect()->route('cms.trangchu');
        } else {
            return redirect()->route('cms.login');
        }
    }
}
