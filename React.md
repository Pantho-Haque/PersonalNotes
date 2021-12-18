- [installation](#installation)
- [Router setup](#router-setup)
- [Layout](#layout)
- [Component](#component)
  - [class component](#class-component)
  - [functional component](#functional-component)
- [props](#props)
- [State & Lifecycle](#state--lifecycle)

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
    <Box w="100%">
      <Navbar />
      {props.children}
    </Box>
  );
}
```

### Component

#### class component

//statefull component

```jsx
//creating component
class Comp extends React.Component {
  print() {
    return <></>;
  }

  render() {
    return <></>;
  }
}

//calling component (not-extended)
const classComp = new Comp();
classComp.print();

// calling component (extended)
<Comp />; //calles the render mathod autometically
```

#### functional component

```jsx
//creating component
function Comp() {
  return <>// element</>;
}

// calling component
<Comp />;
```

### props

    - props cannot be changed inside of a component

[in a class component]

```jsx
    // sending props
    <ClassComp text="theText">

    // receiving in a class component
    {this.props.text}
```

[in a functional component]

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
    //another way (object destructuring)
    export default function Output({text,setText}){
        return(
            {text}
            {setText(" ")}
        );
    }
```

### State & Lifecycle

// in class component

```jsx
class Comp extends React.Component {
  //using constructor - when we need to pass props value into our state values
  constructor(props) {
    super(props);
    this.state = {
      key: "value",
    };
  }

  //normally
  state = {
    key: "Value",
  };

  functionThatChangesState() {
    //normally merging the state
    this.setState({
      key: "value",     //only change the value of key , others are untouched
    });


    //if we need the previous state of a key
    this.state((state, props) => ({
      // state is the previous state
      // props is the value passing through component
      key: state.key + props.increment,
    }));
  }
  componentDidMount() {
    //after updating dom this function calls
  }
  componentWillUnmount() {
    //before unmounting the app
  }

  render() {
    return <></>;
  }
}
```
