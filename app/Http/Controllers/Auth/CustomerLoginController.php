<?php

namespace App\Http\Controllers\auth;

use App\User;
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

    public function postRegister() {
        //
    }


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
