- [installation](#installation)
- [Router setup](#router-setup)
- [Layout](#layout)
- [props](#props)



### installation

```sh
    npx create-react-app google-keep --template @chakra-ui
    npm install react-router-dom
```

### Router setup

```jsx
    import { Route, Switch, BrowserRouter as Router } from "react-router-dom";

    export default function Routes(){
        return (
            <Router>
            <Switch>
                <Route path="/" exact component={} />
                <Route path="/../" exact component={} />
            </Switch>
            </Router>
        );
    };
```

### Layout
**NavLayout.js**

```jsx
    export default function NavLayout(props) {
        return (
            <Box
                w="100%"
            >
                <Navbar />
                {props.children}
            </Box>
        )
    }
```


### props 

```jsx
    // send props

    import Output from "../Output.js"

    const [value, setValue] = useState("");
    <Output text={value} setText={setValue}/>

    // receive props

    export default function Output(props){
        return(
            {props.text}
            {props.setText(" ")}
        );
    }
```

