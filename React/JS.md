### Asynchronous - callbacks,promises and async-await

##### callback 

<small style="color:blue;">// a function passed through another function</small>

```js
const takeOrder = (cus, callback) => {
  console.log(`taking ${cus}`);
  callback(cus);
};

const processOrder = (cus, callback) => {
  console.log(`processing ${cus}`);

  setTimeout(() => {
    console.log(`timeout ${cus}`);
    console.log(`processed ${cus}`);
    callback(cus);
  }, 3000);
};
const completeOrder = (cus) => {
  console.log(`finished ${cus}`);
};

takeOrder(1, (customer) => {
  processOrder(customer, (customer) => {
    completeOrder(customer);
  });
});
```

###### Promise

```js
const hasMeeting = false;
const meetingDetails = {
  name: "Technical Meeting",
  location: "Google Meet",
  time: "10:00 PM",
};

// construct a promise
const meeting = new Promise((resolve, reject) => {
  // resolve and reject are 2 callback functions to handle execution.
  if (hasMeeting) {
    resolve(meetingDetails);
  } else {
    reject(`meeting already scheduled!`);
  }
});

//if only one of resolve and reject  perform
const addToCalender = () => {
  const calender = `${meetingDetails.name} has been scheduled on ${meetingDetails.location} at ${meetingDetails.time}`;
  return Promise.resolve(calender);
};

// call miltiple promise one after another
meeting
  .then(addToCalender)
  .then((res) => {
    console.log(res);
    // resolved data
  })
  .catch((err) => {
    // rejected data
    console.log(err);
  });

// call multiple promises at the same time ans get the output in one array
Promise.all([meeting, addToCalender]).then((res) => {
  console.log(res); // here res[0] is the resolve of meeting and res[1] is the resolve of addToCalender
});

// call multiple promises at the same time and get the output of one promise who resolves first
Promise.race([meeting, addToCalender]).then((res) => {
  console.log(res);
});
```

###### async-await

```js
// async function always returns a promise.
const myMeeting=async()=>{
  tyr{
    const md= await meeting;
  const calender = await addToCalender(md);
  console.log(calender);
  }catch{
    console.log(`something is wrong`)
  }
}
myMeeting();
```

### AJAX

```js
const sendReq = (method, url, data) => {
  const promise = new Promise((resolve, reject) => {
    const xhr = new XMLHttpRequest();
    // prepare
    xhr.open(method, url);

    //server will understand that we are sending json file
    xhr.setRequestHeader("content-Type", "application/json");

    xhr.resposeType = "json"; // this time data will receives in json  formate otherwise it will come as string
    //sending req
    xhr.send(data);

    xhr.onload = () => {
      //here can be any application-specific error from server
      if (xhr.status >= 400) {
        reject(xhr.response);
      } else {
        resolve(xhr.response);
      }
    };

    // error in browser-Side which is  client-apecific error
    xhr.onerror = () => {
      reject("something was wrong");
    };
  });
  return promise;
};
```

##### Get -> GET THE DATA

```js
const getData = () => {
  sendReq("GET", "https://jsonplaceholder.typicode.com/todos/1")
    .then((response) => {
      console.log(response);
    })
    .catch((err) => {
      console.log(err);
    });
};
```

##### POST -> SEND THE DATA

```js
const sendData = () => {
  const dataToSend = {
    title: "foo",
    body: "bar",
    userId: 1,
  };
  sendReq(
    "POST",
    "https://jsonplaceholder.typicode.com/posts",
    JSON.stringify(dataToSend)
  )
    .then((response) => {
      console.log(response);
    })
    .catch((err) => {
      console.log(err);
    });
};
```

##### PUT -> EDIT THE DATA

##### DELETE -> DELETE THE DATA

##### OPTION

##### HEAD

### Reducer

```js
array.reduce((accumulator, currentvalue) => {
  // accumulator is the initial value of this function . By default it is 0;
  // after an iteration the value of iteration exchanges with the currentvalue of this iteration
  //and the currentvalue will become null.

  return accumulator + currentvalue;
}, initialValue);
```
