## install
```sh
    npm install firebase
```

## initialize

#### firebase.js
```js
    import { initializeApp } from 'firebase/app';
    import { getDatabase } from 'firebase/database';

    const firebaseConfig = {
    apiKey: 'AIzaSyB_LILWgtc9QbLSF8hwxab9yGknByFH_O4',
    authDomain: 'myclassmate360.firebaseapp.com',
    databaseURL: 'https://myclassmate360-default-rtdb.firebaseio.com',
    projectId: 'myclassmate360',
    storageBucket: 'myclassmate360.appspot.com',
    messagingSenderId: '387771362880',
    appId: '1:387771362880:web:e582619557433fa05db9a5',
    };
    const app = initializeApp(firebaseConfig);
    const db = getDatabase();
    export { db };


```


## get the data 

```js 
    import {ref,onValue,set} from 'firebase/database'
    import {db} from "../../firebase.js"

    const [state,setState]=useState({});

    onValue(
        ref(db,'/'),
        (e)=>{
            console.log(e.val());
        },
        {
            onlyOnce:true
        }
    );
```