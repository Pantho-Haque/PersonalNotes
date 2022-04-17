## express()

```js
const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send("this is home page");
});

app.post("/", (req, res) => {
  console.log(req.body);
  res.send("this is home page with post request");
});

app.listen(3000, () => {
  console.log("listening on port 3000");
});
```

### .json()

```js
app.use(express.json());
// Content-Type = application/json
// to parse the json data we pass in the url body
// data can be found in req.data object
```

### .raw()

```js
app.use(express.raw());
// Content-Type = application/octet-stream
// to parse the body Buffer data we pass in the url body
// data can be found in req.data buffer
```

### .text()

```js
app.use(express.text());
// Content-Type = text/plain
// to parse the body text we pass in the url body
// data can be found in req.data string
```

### .urlencoded()

```js
app.use(express.urlencoded());
// Content-Type = application/x-www-form-urlencoded
// to parse the body data we pass in the url body
// data can be found in req.data string
```

### .static()

```js
app.use(
  express.static(`${__dirname}/public/`, {
    index: "index.html",
  })
);
// a static can be found through browser search
// thus we can access any file in our local directory
```

### .Router()

```js
const router = express.Router({
  caseSensitive: true,
});
app.use(router);

router.get("/", (req, res) => {
  res.send("Router req received");
});
router.post("/", (req, res) => {
  res.send("Router req received by post");
});
// a static can be found through browser search
// thus we can access any file in our local directory
```

## Applications

### Properties

#### locals

```js
app.locals.name = "Pantho";
// a variable that can be access from entire app using app.locals.title or req.app.locals.title
```

#### mountpath

```js
const express = require("express");
const app = express(); //main app
const admin = express(); //sub app

app.use("/admin", admin);

admin.get("/dashboard/home", (req, res) => {
  console.log(admin.mountpath);
  res.send("admin dashboard");
});
// admin.mountpath contains the mounted path of current sub app
```

### Event

#### mount

```js
admin.on("mount", (parentApp) => {
  console.log(parentApp);
});
```

### Method

```js
app.all(); // accessed by all type of method
app.get(); // accessed by get type of method
app.post(); // accessed by post type of method
app.put(); // accessed by deletePut type of method
app.delete(); // accessed by delete type of method

app.enable(name); // enabling any setting of the app
app.disable(name); // disabling any setting of the app
app.enabled(name); // the setting enabled or not
app.disabled(name); // the setting disabled or not

app.set("title", "my site"); // set a settings named title
app.get("title"); // get the settings state

app.listen(portNumber, () => {
  // callback function that runs after listening the port
});

app.path(); // returns the canonical path of the app as string.
app.use(); // to run or use any middleware
```

#### app.param()

```js
app.param("id", (req, res, next, id) => {
  const user = {
    userId: id,
    name: "bangladesh",
  }
  req.userDetails = user
  next()
})

app.get("/user/:id", (req, res) => {
  console.log(req.userDetails)0
  res.send("getting the id from routing0")
})
```

#### app.route()

<i>to process different method in same route</i>

```js
app
  .route("/about/mission")
  .get((req, res) => {
    res.send("application with get");
  })
  .post((req, res) => {
    res.send("application with post");
  })
  .put((req, res) => {
    res.send("application with put");
  });
  .delete((req, res) => {
    res.send("application with delete");
  });
```

## Request

### request Properties

```js
req.baseUrl
   .originalUrl
   .path
   .hostname {"localhost"}
   .ip
   .method {"get","post","put","delete}"
   .protocol {"http","https"}
   .params
   .query
   .body  // app.use(express.json())
   .cookies // npm i cookie-parser
            // const cookieParser=require("cookie-parser")
           // app.use(cookieParser())
   .signedCookies
   .secure  // for http its false
   .app   // contains full app object inside of req
   .route
```

### Request Method

```js
req.accepts("json"); // does frontend accepts json or not
   .get("headerName"); // gets the value of particular header of a request
```

## Response

### Response Properties

```js
res.app; // contains full app object inside of res
   .headerSent; // returns boolean that response headers already sent or not
   .local; // local variables for templates like ejs
```

### Response Methods

```js
res.cookie("cookieName","cookieValue",{
  // options from documentation
});
   .clearCookie()
   .end()
   .send(data)
   .json({})        // returns a json data to client in response
   .status()        // set the status or response
   .sendStatus()    // set the status and end the response as well
   .render()        // renders a view --ejs
   .format({
      "text/plain":()=>{}
      "text/html":()=>{}
      "application/json":()=>{}
      default:()=>{
        res.status(406).send("not acceptable")
      }
    })                         // format the data as like as client accepts type of data
   .location("route")      // set a header as route
   .redirect("route")      // redirect to route and shows the output of redirected route
   .set("headerName","headerValue") // set the value of header
   .get("headerName")      // get the value of a particular header

```

## Middleware

1. application level
2. router level
3. error-handling
4. built-in (express.json, express.static)
5. third party (cookie-parser)

```js
const middleware1 = (req, res, next) => {
  // executes js
  next();
};
const middleware2 = (req, res, next) => {
  // executes js
  next("an error occurred "); // any value inside next function will consider as an error and runs the error handling middleware .
};
app.use(middleware2);
app.use(middleware1); // order of declaring middleware is important , cause node performs
```

```js
// middleware function with additional data we want to pass
const theFunction = (options) => {
  // use options
  const middleware = (req, res, next) => {
    // executes js
    next();
  };
};
app.use(theFunction(options));
```

```js
// error handling middleware
const ErrorThrowingMiddleware = (req, res, next) => {
  // executes js
  throw new Error("This is an error");
};

const ErrorHandlingMiddleware = (err, req, res, next) => {
  // executes js
  console.log(err.message);
  res.status(500).send("there is a server side error !");
};
app.use(ErrorHandlingMiddleware);
```

## Router

### Router Setup

#### routerFile.js

```js
const express = require("express");

const adminRouter = express.Router();

adminRouter.get("/", (req, res) => {
  // admin dashboard
});

adminRouter.get("/login", (req, res) => {
  // admin login function
});

module.exports = adminRouter;
```

#### index.js

```js
const express = require("express");
const adminRouter = require("./routerFile.js");

const app = express();

app.use("/admin", adminRouter); // thus every hit on /admin route will follow adminRouter
```

## Router Properties

```js
const log = (req, res, next) => {
  console.log("logging");
  next();
};

adminRouter.all("*", log); // * -> all route , effects only on adminRouter
```

## Router params

```js
// a particular middleware for a particular parameter in a specific route
adminRouter.param("paramName", (req, res, next, id) => {
  // when there has any parameter name paramName in any route ,
  // run this middleware
  req.paramName = modification(id);
  next();
});
```

```js
// set a particular behavior for a param and its value in a specific route
adminRoute.param((paramName, option) => (req, req, next, val) => {
  if (val === option) next();
  else res.sendStatus(403);
});
adminRoute.param(paramName, option); // declaring
```

```js
// how to get the value from url as param
adminRouter.get("/:param1", (req, res) => {
  res.send(req.user);
});
```

### Router.Route() method

```js
adminRouter
  .route("/user")
  .get((req, res) => {
    res.send("application with get");
  })
  .post((req, res) => {
    res.send("application with post");
  })
  .put((req, res) => {
    res.send("application with put");
  });
  .delete((req, res) => {
    res.send("application with delete");
  });
```

### Router.use() method

```js
adminRouter.use("use a middleware");
```

### Route paths

```js
  "/ab?cd"    -> acd , abcd
  "/ab+cd"    -> abcd, abbcd, abbbcd and so on
  "/ab*cd"    -> abcd, ab(anything)cd
  "/ab(cd)?e" -> abe , abcde
  "/a/"       -> anything with an "a"
  "any RegExp"
```

## Error handling

```sh
  when we start writing our response using res.write(),
  headers have been sent to the client ,
  and when we want to send the request again to the client it occurs an error.
```

```js
// express has a default error handling middleware only for synchronous functions or process
// our customized error handling middleware should be the last middleware of pur app
app.use((err, req, res, next) => {
  if (res.headerSent) {
    next("there was a problem");
  } else {
    if (err.message) res.status(500).send(err.message);
    else res.send("there was a problem");
  }
});
```

```js
// 404 error handler
// this middleware should be placed after all route we create
app.use((req, res, next) => {
  next("requested url was not found");
});
```

```js
// error handling for asynchronous function
fs.readFile("/unknownFile", "utf-8", (err, data) => {
  if (err) next(err); // redirect to default error handling middleware
  else res.send(data);
});
```

```js
// error handling using try-catch
try {
  throw "the error message";
} catch (err) {
  next(err);
}
```

```js
// chaining middleware function - when we can have multiple error case
app.get("/", [
  (req, res, next) => {
    fs.readFile("/unknownFile", "utf-8", (err, data) => {
      if (err) next(err); // redirect to default error handling middleware
      else res.send(data);
    });
  },
  (req, res, next) => {
    // occurred an error which can be deal by default synchronous error handling middleware
  },
]);
```

## FileHandling multer

// to handle multipart data - use multer

```js
npm i multer
```

```js
  const multer = require("multer");
  const path=require("path");
// define storage
const storage = multer.diskStorage({
  destination:(req,file,cd)=>{
    // file_returns
        //   {
        //     fieldname:"file_name_property",
        //     originalname:"filenameInUserPc",
        //     ecoding:"7bit",
        //     mimetype:"image/png"
        //   }
    cb(null,"./upload/")
  },
  filename:(req,file,cb)=>{
    // important File.pdf => importtant-file-3467756347463.pdf

    const fileExt=path.extname(file.originalname);
    const fileName = file.originalname
                        .replace(fileExt,"")
                        .toLowerCase()
                        .split(" ")
                        .join("-")
                        +"-"+Date.now()+fileExt

    cb(null,fileName);

  }
})

var upload =multer({
    storage:storage,
    limits:{
      fileSize: 1000000 //  1MB
    },
    fileFilter:(req,file,cb)=>{
        // file_returns
        //   {
        //     fieldname:"file_name_property",
        //     originalname:"filenameInUserPc",
        //     ecoding:"7bit",
        //     mimetype:"image/png"
        //   }
        if(
          file.mimetype==="image/png" ||
          file.mimetype==="image/jpg" ||
          file.mimetype==="image/jpeg"
        ) {
          cb(null , true);  // cb(error,IsValid)
        }else{
          cb(new Error("only .jpg .png or .jpeg format allowed!"))
        }
    }
  })



  // upload a single file
  app.post("/", upload.single("file_name_property"),(req,res)=>{
    // req.files returns
    // {
    //   fieldname:"file_name_property",
    //         originalname:"filenameInUserPc",
    //         ecoding:"7bit",
    //         mimetype:"image/png",
    //         destination:"./upload/",
    //         filename:"importtant-file-3467756347463.png",
    //         path:"upload/importtant-file-3467756347463.png",
    //         size:344,
    // }
    res.send("hello world");
  })

  //upload multiple files
  app.post("/", upload.array("file_name_property",NumberOfFile),(req,res)=>{
    res.send("hello world");
  })

  //upload multiple files from multiple input fields
  app.post("/", upload.fields([
    {name:"file_name_property1",maxCount:NumberOfFile1}
    {name:"file_name_property2",maxCount:NumberOfFile2}
  ]),(req,res)=>{
    res.send("hello world");
  })

  //not to upload files
  app.post("/", upload.none(),(req,res)=>{
    res.send("hello world");
  })

```
