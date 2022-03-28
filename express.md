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
app.use();
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

_to process different method in same route_

```js
app
  .route("/about/mission")
  .get((req, res) => {
    res.send("application with get");
  })
  .post((req, res) => {
    res.send("application with get");
  })
  .put((req, res) => {
    res.send("application with get");
  })``;
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

