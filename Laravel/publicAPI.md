- [Installation](#installation)
  - [Project](#project)
    - [Create a project](#create-a-project)
    - [Run the server](#run-the-server)
- [Routing](#routing)
  - [Route](#route)
    - [web.php](#webphp)
    - [api.php](#apiphp)
- [Database](#database)
  - [command](#command)
  - [.env](#env)
  - [create\_user\_table.php](#create_user_tablephp)
    - [migrate to database](#migrate-to-database)
  - [UserSeeder.php](#userseederphp)
  - [DatabaseSeeder.php](#databaseseederphp)
    - [seed to database](#seed-to-database)
- [Controller](#controller)
  - [index](#index)
  - [show](#show)
  - [search](#search)
  - [store](#store)
  - [update](#update)
  - [delete](#delete)

# Installation

## <u>Project</u>

### Create a project

```cmd
    laravel new backend(laravel)
    cd backend(laravel)
```

### Run the server

```cmd
    php artisan serve
```

# Routing

## <u>Route</u>

### web.php

```php
// can be access from -> http://127.0.0.1:8000/

Route::get('/', function () {
    return view('welcome'); // the view we want to show
                            // or we can send another response
                            // return "hi there";
});

```

### api.php

```php
// can be access from -> http://127.0.0.1:8000/api/
// details in boot() from  App\Providers\RouteServiceProvider

            Route::middleware('api')
                ->prefix('api')     // this prefix making the /api/ important
                ->group(base_path('routes/api.php'));

            Route::middleware('web')
                ->group(base_path('routes/web.php'));

// in Route

Route::get('/', function () {
    return $request->user();
});

```

# Database

## <u>command</u>

```cmd
    php artisan make:model User -msc
    <!-- creates a model along with migration, seeder , controller -->

    <!-- otherwise in separate -->
    php artisan make:migration create_user_table
    php artisan make:seeder UserSeeder
    php artisan make:controller UserController  --resource
```

## <u>.env</u>

```env
DB_DATABASE=newdb
<!-- newdb is the name of database we are using for this api -->
```

## <u>create_user_table.php</u>

```php
// creating a schema of that table
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->string('profile_pic')->nullable();
            $table->unsignedBigInteger('number_of_folders')->default(0);
            $table->unsignedBigInteger('number_of_files')->default(0);
            $table->boolean('isAdmin')->default(false);
            $table->boolean('visibility')->default(true);
            $table->float('used_storage')->default(0.0);
            $table->rememberToken();
            $table->timestamps();
        });
```

### migrate to database

```cmd
    php artisan migrate
```

## <u>UserSeeder.php</u>

```php
<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Faker\Factory  as Faker;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        $faker = Faker::create();
        foreach (range(1,5) as $value) {
            DB::table("users")->insert([
                'name' => $faker->name(),
                'email' => $faker->unique()->safeEmail(),
                'password' => Hash::make('password'),
                'used_storage' => $faker->numberBetween(0, 50),
            ]);
        }
    }
}

```

## <u>DatabaseSeeder.php</u>

```php
<?php

namespace Database\Seeders;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $this->call([
            UserSeeder::class
        ]);
    }
}

```

### seed to database

```cmd
    php artisan db:seed
```

# Controller

## index

```php
    // list of all resource

    public function index()
    {
        return User::all();
    }

    // the routing

    Route::get("/users", [UserController::class, 'index']);
```

## show

```php
    // get the resource with specified id

    public function show(string $id)
    {
        return User::find($id);
    }

    // the routing

    Route::get("/users/{id}", [UserController::class, 'show']);
```

## search

```php
    // search from table where the query matches with
    //name or email

    public function search($query)
    {
        return User::where('email', 'like', '%'.$query.'%')
            ->orWhere('name', 'like', '%'.$query.'%')
            ->get();
    }

    // the routing

    Route::get("/users/search/{query?}", [UserController::class, 'search']);


```

## store

```php
    // store the resource

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'email' => 'required',
            'password' => 'required',
        ]);
        return User::create($request->all());
    }

    // the routing

    Route::post("/users", [UserController::class, 'store']);

    // might need to pass header={
    //     "accept":"application/json"
    // } while we req from frontend


    // the model

    protected $fillable = [
        'name',
        'profile_pic',
        'password',
        'email',
        'number_of_folders',
        'number_of_files',
        "isAdmin",
        'visibility',
        'used_storage'
    ];
```

## update

```php
    // update the resource with specified id
    // hidden properties cant be changed by this method

    public function update(Request $request,$id)
    {
        $user= User::find($id);
        $user->update($request->all());
        return $request;
    }

    // the routing

    Route::put("/users/{id}", [UserController::class, 'update']);

    // might need to pass header={
    //     "accept":"application/json"
    // } while we req from frontend

```

## delete

```php
    // delete the resource with specified id
    // hidden properties cant be changed by this method

    public function destroy( $id)
    {
        return User::find($id)->delete();
    }

    // the routing

    Route::delete("/users/{id}", [UserController::class, 'destroy']);

```
