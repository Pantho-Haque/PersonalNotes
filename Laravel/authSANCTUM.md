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
- [Get My data](#get-my-data)
  - [controller](#controller-1)
  - [Frontend req](#frontend-req-1)
- [Logout](#logout)
  - [controller](#controller-2)
  - [Frontend req](#frontend-req-2)
- [Login](#login)
  - [controller](#controller-3)
  - [Frontend req](#frontend-req-3)

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

# Get My data

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
        ]);
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

<!-- php artisan storage:link -->
<!-- link given in database -> public/backendfiles/9/profilepic.jpg -->
<!-- link can be access by that file -> http://127.0.0.1:8000/storage/backendfiles/9/profilepic.jpg -->
