### install 

    ```sh 
        npm install axios
    ```

### helpers.js

    //fetching data 

    ```js
        import axios from 'axios';

        const api = axios.create({
            baseURL: 'https://jsonplaceholder.typicode.com',
        });

        export const getPosts = (req) => {
        return api
            .get(`/posts/${req.id}`)
            .then(response => {
            return response.data;
            })
            .catch(error => {
            return { error: error.response };
            });
        };
    ```
    // get = read , post =write , put =update , delete= erase

### Processing.js

    //data modification

    ```js

        function fetchData(){
            api
            .getPosts()
            .then(
                (data)=> console.log(data)
            );
        }
        
    ```