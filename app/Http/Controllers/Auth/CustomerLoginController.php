<?php

namespace App\Http\Controllers\auth;

use App\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
use Laravel\Socialite\Facades\Socialite;


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

    public function postRegister(Request $request) {
        //
//        $input = $request->all();

        //check mail is extis?
        $g = User::select('*')->where('email', $request->input('email'))->count();

        if ($g != 0) {
            return redirect()->route('register')->with('mess', 'Email already exists!!!');
        } else {
            //send mail to user to confirm
//            Mail::send('mail.mail', ['key' => $randomKey, 'email' => $request->input('email')], function ($message) use ($input) {
//                $message->to($input["email"], 'Client')->subject('Confirm Register');
//
//            });

            //update user's information into database
            $user = new User;
            $user->name = $request->input('name');
            $user->email = $request->input('email');
            $user->birthday = $request->input('birthday');
            $user->password = Hash::make($request->input('password'));
            $user->phone = $request->input('phone');
            $user->province = $request->input('province');
            $user->address = $request->input('address');
            $user->id_card_number = $request->input('id_card_number');
            $user->sex = $request->input('sex');
            $user->save();
            //return login view
            return redirect()->route('index.login.get')->with('mess', 'Đăng ký thành công');
    }}


    public function redirectToProvider($provider)
    {

        return Socialite::driver($provider)->redirect();
    }

    public function handleProviderCallback($provider)
    {
        $user = Socialite::driver($provider)->stateless()->user();
        $authUser = $this->findOrCreate($user, $provider);
        Auth::login($authUser, true);
        return redirect()->route("index.home.get");
    }
    public function findOrCreate($user, $provider)
    {
        $userUnique = User::where('email', $user->email)->first();
        if ($userUnique) {
            return $userUnique;
        }
        $authUser = User::where('provider_id', $user->id)->first();
        if ($authUser) {
            return $authUser;
        }
        return User::create([
            'name' => $user->name,
            'email' => $user->email,
            'provider' => strtoupper($provider),
            'provider_id' => $user->id,
        ]);
    }
}
