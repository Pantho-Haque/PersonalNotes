- [install](#install)
- [helpers.js](#helpersjs)
- [Processing.js](#processingjs)

### install

```sh
    npm install axios
```

### helpers.js

```js
//fetching data
import axios from "axios";

const api = axios.create({
  baseURL: "https://jsonplaceholder.typicode.com",
});

export const getPosts = (req) => {
  return api
    .get(`/posts/${req.id}`)
    .then((response) => {
      return response.data;
    })
    .catch((error) => {
      return { error: error.response };
    });
};

/*******************************/
// another way

const getData = async () => {
  const res = await axios.get(
    "https://randomuser.me/api/?gender,name,nat,location,picture,email&results=20"
  );
  return res.data.results;
}; //which returns a promise

export default function App() {
  const [result, setResult] = useState();
  useEffect(() => {
    getData().then((res) => setResult(res));
  }, []);
  function getting() {
    return result && result.map((el) => <li>{el.email}</li>);
  }
  return <ul>{getting()}</ul>;
}
```

    // get = read , post =write , put =update , delete= erase

### Processing.js

    //data modification

```js
import * as api from "../helpers";
function fetchData() {
  api.getPosts().then((data) => console.log(data));
}
```
