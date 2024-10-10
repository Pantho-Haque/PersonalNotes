- [Intallation](#intallation)
  - [install the library](#install-the-library)
  - [create the migration table](#create-the-migration-table)
  - [migrate](#migrate)
  - [enabling middleware to api](#enabling-middleware-to-api)
    - [App\\Http\\Kernel.php](#apphttpkernelphp)
- [Routing](#routing)
- [Registration](#registration)
  - [controller](#controller)
  - [Frontend req](#frontend-req)
- [Get User data](#get-user-data)
  - [controller](#controller-1)
  - [Frontend req](#frontend-req-1)
- [Logout](#logout)
  - [controller](#controller-2)
  - [Frontend req](#frontend-req-2)
- [Login](#login)
  - [controller](#controller-3)
  - [Frontend req](#frontend-req-3)
- [Change Password](#change-password)
  - [controller](#controller-4)
  - [Frontned req](#frontned-req)
- [Reset Password](#reset-password)
  - [creating a model and controller](#creating-a-model-and-controller)
  - [setting up env file](#setting-up-env-file)
  - [Password Reset Controller](#password-reset-controller)
  - [Password reset model](#password-reset-model)
  - [migrate password reset table](#migrate-password-reset-table)
  - [config/cors.php](#configcorsphp)
  - [middleware/Cors.php](#middlewarecorsphp)

# Intallation

**_already-installed-in-laravel-9_**

## install the library

```cmd
    composer require laravel/sanctum
```

## create the migration table

```cmd
    php artisan vendor:publich --provider="Laravel\Sanctum\SanctumServiceProvider"
```

## migrate

```cmd
    php artisan migrate
```

## enabling middleware to api

### App\Http\Kernel.php

```php

    protected $middlewareGroups = [
        'api' => [
            \Laravel\Sanctum\Http\Middleware\EnsureFrontendRequestsAreStateful::class,
            \Illuminate\Routing\Middleware\ThrottleRequests::class.':api',
            \Illuminate\Routing\Middleware\SubstituteBindings::class,
        ],
    ];

```

# Routing

```php
    Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
        return $request->user();
    });
```

# Registration

## controller

```php
    public function register(Request $request){
        $request->validate([
            'name' => 'required|string|max:255',
            'profile_pic'=>'required|file',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:4|confirmed',
        ]);


        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'used_storage' => 0, // set initial used storage to 0
            'isAdmin' => $request->isAdmin ? $request->isAdmin : false,
        ]);

        // saving the profile picture
        $profile_pic = $request->file('profile_pic')->storeAs(
            'public/backendfiles/'.$user->id  ,
            'profilepic.'. $request->file('profile_pic')->getClientOriginalExtension()
        );

        $user->profile_pic = $profile_pic;
        $user->save();

        $token = $user->createToken($request->email)->plainTextToken;

        return response([
            "user"=>$user,
            "token"=>$token
        ],201);
    }


    // the Route
    Route::post("/register", [UserController::class, 'register']);

```

## Frontend req

```js
import axios from "axios";

const instance = axios.create({
  baseURL: "http://127.0.0.1:8000/api",
  headers: {
    Accept: "application/json",
  },
});

let formdata = new FormData();
formdata.append("name", "pantho");
formdata.append("email", "pantho@gmail.com");
formdata.append("password", "panthohaque");
formdata.append("password_confirmation", "panthohaque");
formdata.append(
  "profile_pic",
  fs.createReadStream(
    "c:UsersUSEROneDrivePicturesCamera Rollafterfocus_1535316047788.jpg"
  )
);

let response = await instance.post("/register", formdata);
console.log(response.data);
```

# Get User data

## controller

```php
    public function me(){
        return auth()->user();
    }

    Route::middleware(['auth:sanctum'])->group(function () {
        Route::get("/me", [UserController::class, 'me']);
    });

```

## Frontend req

```js
import axios from "axios";

const instance = axios.create({
  baseURL: "http://127.0.0.1:8000/api",
  headers: {
    Accept: "application/json",
    Authorization: "Bearer 2|4FbLRVYuUx4enT01xOYGh2sX3Du6UXMYpRO6HIdA",
  },
});

let response = await instance.get("/me");
console.log(response.data);
```

# Logout

## controller

```php
    public function logout(){
        auth()->user()->tokens()->delete();
        return response([
            "message"=>"Successfully logged out"
        ],200);
    }

    // the routing
    Route::middleware(['auth:sanctum'])->group(function () {
        Route::post("/logout", [UserController::class, 'logout']);
    });

```

## Frontend req

```js
import axios from "axios";

const instance = axios.create({
  baseURL: "http://127.0.0.1:8000/api",
  headers: {
    Accept: "application/json",
    Authorization: "Bearer 2|4FbLRVYuUx4enT01xOYGh2sX3Du6UXMYpRO6HIdA",
  },
});

let response = await instance.post("/logout");
console.log(response.data);
```

# Login

## controller

```php
    public function login(Request $request){
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $user = User::where("email", $request->email)->first();

        if(!$user || !Hash::check($request->password, $user->password)){
            return response([
                "message"=>"The provided credentials are incorrect"
            ],401);
        }

        $token = $user->createToken($request->email)->plainTextToken;

        return response([
            "user"=>$user,
            "token"=>$token
        ],200);
    }

```

## Frontend req

```js
import axios from "axios";

const instance = axios.create({
  baseURL: "http://127.0.0.1:8000/api",
  headers: {
    Accept: "application/json",
    "Content-Type": "application/json",
  },
});

let bodyContent = JSON.stringify({
  email: "pantho@gmail.com",
  password: "panthohaque",
});

let response = await instance.post("/login", bodyContent);
console.log(response.data);
```

# Change Password

## controller

```php
    public function change_password(Request $request){
        $request->validate([
            'prevPass' => 'required',
            'password' => 'required|confirmed',
        ]);

        $user=auth()->user();
        if(Hash::check($request->prevPass, $user->password)){

            $user->password=Hash::make($request->password);
            $user->save();
            return response([
                "message"=>"Password Changed",
            ],200);
        }

        return response([
            "message"=>"Password didnt match"
        ]);
    }

  // the route

  Route::middleware(['auth:sanctum'])->group(function () {
    Route::post("/changepassword", [UserController::class, 'change_password']);
  });

```

## Frontned req

```js
import axios from "axios";

const instance = axios.create({
  baseURL: "http://127.0.0.1:8000/api",
  headers: {
    Accept: "application/json",
    Authorization: "Bearer 3|McBQPZ3hjNoJjEUqtNWME7WIXes3jsJGiTBPKBsK",
    "Content-Type": "application/json",
  },
});

let bodyContent = JSON.stringify({
  prevPass: "panthohaque",
  password: "1907075",
  password_confirmation: "1907075",
});

let response = await instance.post("/changepassword", bodyContent);
console.log(response.data);
```

# Reset Password

## creating a model and controller

```cmd
  php artisan make:model PasswordReset -c
```

## setting up env file

```env
<!--

1.Login to your gmail account e.g. myaccount.google.com afaik
2.Go to Security setting and Enable 2 factor (step) authentication
3.After enabling this you can see app passwords option. Click [here!](https://myaccount.google.com/apppasswords)
4.And then, from Your app passwords tab select Other option and put your app name and click GENERATE button to get new app password.
5.Finally copy the 16 digit of password and click done. Now use this password instead of email password to send mail via your app.

 -->
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.om
MAIL_PORT=587
MAIL_USERNAME=panthohaque927908@gmail.com
MAIL_PASSWORD=jfonsxzjwnjxpcby
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS="filedrive@gmail.com"
MAIL_FROM_NAME="${APP_NAME}"

```

## Password Reset Controller

```php


use App\Models\PasswordReset;
use App\Models\User;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Illuminate\Mail\Message;
use Carbon\Carbon;

class PasswordResetController extends Controller
{
    public function send_reset_password_email(Request $request){
        $request->validate([
                "email"=>"required|email",
        ]);
        $email = $request->email;

        $user=User::where("email",$email)->first();
        if(!$user){
            return response([
                "message"=>"Email Doesnt exist",
                "status"=>"Failed"
            ],404);
        }

        $token = Str::random(60);

        Mail::send('resetpass',['token'=>$token],function(Message $message)use($email){
            $message->subject("Reset Your Email");
            $message->to($email);
        });

        PasswordReset::create([
            "email"=>$email,
            "token"=>$token,
            'created_at'=>Carbon::now()
        ]);

        return response([
            "message"=>"Check yout email to reset your password",
            "status"=>"success"
        ],200);
    }


    public function resetingPassword(Request $request){
        $request->validate([
                "token"=>"required",
                "password"=>"required|confirmed",
        ]);

        $token=$request->token;
        $passreset=PasswordReset::where('token',$token)->first();

         if(!$passreset){
            return response([
                "message"=>"Token is Invalid or Expired",
                "status"=>"Failed"
            ],404);
        }


        $user=User::where("email", $passreset->email)->first();
        $user->password= Hash::make($request->password);
        $user->save();

        return response([
            "message"=>"Password Reset Success",
            "status"=>"success"
        ],200);
    }
}

```

## Password reset model

```php

class PasswordReset extends Model
{
    use HasFactory;
    const UPDATED_AT=null;

    protected $fillable=[
        "email",
        "token"
    ];
}

```

## migrate password reset table

```cmd
  php artisan migrate
```

## config/cors.php

```php
return [
    'paths' => ['api/*', 'sanctum/csrf-cookie','api'],

    'allowed_methods' => ['*'],

    'allowed_origins' => ['*'],

    'allowed_origins_patterns' => [],

    'allowed_headers' => ['*'],

    'exposed_headers' => [],

    'max_age' => 0,

    'supports_credentials' => True,

];

```

## middleware/Cors.php

```php
<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Response;
use Illuminate\Http\Request;

class Cors
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle($request, Closure $next)
    {
        $headers = [
            'Access-Control-Allow-Origin' => "*",
            'Access-Control-Allow-Credentials'=>"true",
            'Access-Control-Allow-Methods' => 'GET, POST, PUT, DELETE',
            'Access-Control-Allow-Headers' => 'Content-Type, Authorization'
        ];

        if ($request->getMethod() == "OPTIONS") {
            return response()->json(['OK'], 200, $headers);
        }

        $response = $next($request);

        foreach ($headers as $key => $value) {
            $response->headers->set($key, $value);
        }

        return $response;
    }
}

```

<!-- php artisan storage:link -->
<!-- link given in database -> public/backendfiles/9/profilepic.jpg -->
<!-- link can be access by that file -> http://127.0.0.1:8000/storage/backendfiles/9/profilepic.jpg -->


