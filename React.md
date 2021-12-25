- [installation](#installation)
- [Router setup](#router-setup)
    - [useParams()](#useparams)
    - [useNavigate()](#usenavigate)
- [Layout](#layout)
- [Component](#component)
  - [class component](#class-component)
  - [functional component](#functional-component)
- [props](#props)
- [State & Lifecycle](#state--lifecycle)
- [this](#this)
- [Event Handling](#event-handling)
- [Conditional Rendering](#conditional-rendering)
- [List and keys](#list-and-keys)
- [Form Handling](#form-handling)
- [Higher Order Component](#higher-order-component)
    - [withCounter.jsx(Pattern)](#withcounterjsxpattern)
    - [ClickCounter.jsx](#clickcounterjsx)
    - [HoverCounter.jsx](#hovercounterjsx)
- [Render Prop](#render-prop)
    - [ClickCounter.jsx](#clickcounterjsx-1)
    - [HoverCounter.jsx](#hovercounterjsx-1)
    - [Counter.jsx(Pattern)](#counterjsxpattern)
    - [App.jsx(Consumer)](#appjsxconsumer)
- [Context API](#context-api)
    - [creat your own](#creat-your-own)
    - [Providing](#providing)
    - [Consumer](#consumer)
- [useState](#usestate)
    - [create your own useState](#create-your-own-usestate)
    - [Rules](#rules)
    - [syntax](#syntax)
    - [fetching data from server](#fetching-data-from-server)
- [useEffect](#useeffect)
    - [side effect](#side-effect)
    - [syntax](#syntax-1)
- [React.memo()](#reactmemo)
- [useCallback()](#usecallback)
- [useMemo()](#usememo)
- [useRef()](#useref)
- [UseReducer()](#usereducer)
    - [Pattern](#pattern)
    - [Fetching data](#fetching-data)
- [Custom Hook](#custom-hook)
- [styling in React](#styling-in-react)
- [css in js](#css-in-js)

### installation

```sh
    npx create-react-app google-keep --template @chakra-ui
    npm install react-router-dom
```

### Router setup

```jsx
// App.js

import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Home from "./Home.jsx";
import Error from "./Error.jsx";
import Dyna from "./Dyna.jsx";

export function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />

        {/* if we want to send props in Home page */}
        {/* using children */}
        <Route path="/" element={<Home />} />

        {/* nested route  
            this will show "Home" in "/home" direction
            both "Home" & "p" in "/home/world" direction
            
            in "/home/world" "p" will be placed where <Outlet/> component has been declared
        */}
        <Route path="/home/*" element={<Home />}>
          <Route path="world" element={<p>Hello world</p>} />
        </Route>

        {/* Dynamic Link -
              Dyna Component will receive a props which contains a specified value.

              Value will be in {props.match.params.category} and
              {props.match.params.topic}

              using useParams() hook:

              import {useParams} from "react-router-dom"
              const {catagory,topic}=useParams();

          */}
        <Route path="/dynamicLinks/:catagory/:topic" element={<Dyna />} />

        {/* notfound component . it must be below everyone*/}
        <Route element={<Error />} />
      </Routes>
    </BrowserRouter>
  );
}

// component.js
import React from "react";
import { Link, Navigate } from "react-router-dom";

export function Component() {
  return (
    <div>
      <Link to="/"> press </Link>

      {/* Link cant take styling but NavLink can */}
      <NavLink
        to="/"
        activeStyle={{
          fontWeight: "bold",
          color: "red",
        }}
        className={(info) => (info.isActive ? classes.active : "")}
      >
        press
      </NavLink>

      {/* Redirection */}
      <Navigate to="/" />
    </div>
  );
}
```

##### useParams()

```jsx
import {useParams} from "react-router-dom";
// if Route path="/home/:post/:id"
// then tha value we pass through post and id variable will get by useParams() hook easily
const { post, id } = useParams();
```

##### useNavigate()

```jsx
const navigate= useNavigate();

// redirection on click a button 
function goToPosts(){
  navigate("/posts",{
    replace:true
  })
}

// go back to previous page 
function goBack(){
  navigate(-1); // to immidiate previous page
  navigate(-2); // to the previous of previous page 
}
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
  function ab() {}
  const bc = () => {};
  return <>element</>;
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
    const {text} = this.props
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


/************************************************************/

  //using constructor - when we need to pass props value into our state values
  constructor(props) {
    super(props);
    this.state = {
      key1:"value1",
      key2: "value2",
    };
  }

  //normally
  state = {
    key: "Value",
  };


  // access through destructuring
  const {key1,key2}=this.state;

/************************************************************/


  functionThatChangesState() {
    //normally merging the state
    this.setState({
      key: "value", //only change the value of key , others are untouched
    });

    //if we need the previous state of a key
    this.state((state, props) => ({
      // state is the previous state
      // props is the value passing through component
      key: state.key + props.increment,
    }));
  }

/************************************************************/


  componentDidMount(prevState,prevProps) {
    // after updating dom this function calls
  }
  componentDidUpdate(prevState,prevProps){
    // calls in every update
  }
  componentWillUnmount(prevState,prevProps) {
    // before unmounting the app
  }

  shouldComponentUpdate(nextProps,nextStates){
    const {change:currentChange,locale:currentLocale}=this.props;
    const {change:nextChange,locale:nextLocale}=nextProps;
    if(currentChange===nextChange && currentLocale===nextLocale){
      return false;
    }
    return true;
  }

/************************************************************/


  render() {
    return <></>;
  }
}
```

### this

```js
const js = {
  name: "javaScript",
  libraries: ["react", "vue", "angular"],
  printLibraries: function () {
    this.libraries.forEach(
      //
      function (library) {
        console.log(`${this.name} loves ${library}`);
      }
      // here this.name cannot be accesed
      // cause here "this" indicates the callback function insted of the object "js"
      /*
          //solve using arraw function
          (library)=>{
            console.log(`${this.name} loves ${library}`)
          }

          //solve by storing "this"
          let self=this; 
          this.libraries.forEach(function(library){
            console.log(`${this.name} loves ${library}`)
          })

          //solve using bind method
          // bind method returns a different function reference each time it calls.
          // bind method creates a new function 
          function(library){
            console.log(`${this.name} loves ${library}`)
          }.bind(this)

        */
    );
  },
};

js.printLibraries();
```

### Event Handling

```jsx

/************************************************************/

  handleClick(e){
    e.preventDefault();   // to prevent the default behaviour of an element

    this.setState({       // here,this is undefined cause this indecates the handleClick function itself , not the class component
      key1:"value",
    })
  }
  //solution
  handleClick=()=>{
    this.setState({
      key1:"value"
    })
  }
  // or
  constructor(props){
    super(props);
    this.state={key1:"value"};
    this.handleClick=this.handleClick.bind(this);
  }
  handleClick(e){
    this.setState({
      key1:"value1",
    })
  }


/************************************************************/

  <button
    onClick={()=>{
      // with arrow function
    }}

    onClick={this.handleClick} // in case of predefined function
                               // this is a reference of a function


     onClick={()=>this.handleClick(param1,param2)} //parameter passing usin arrow function
     onClick={this.handleClick.bind(this,param1,param2)}  //parameter passing using bind
     /*
     //the function
        handleClick=(param1,param2)=>{
          // use params
        }
     */
  > click <button>
```

### Conditional Rendering

```jsx
  // if-else, outside of render() function
  if(){
    var=(<></>)
  }
  else{
    var=(<></>)
  }

  // inline rendering , inside render() function
  { condition ? (

      <></>

    ) : (

      <></>

    )
  }

  // truthy or falsy
  {bool && <></>}

  // for enable or disable
  if(!enable) return null;
              // it must declare before the return part of render function

```

### List and keys

```jsx
import Clock from "./Clock";
export default function ClockList({ quantities = [] }) {
  return (
    <div>
      {quantities.map(() => (
        <Clock key={Math.random()} /> //we should not use array indes as key
      ))}
    </div>
  );
}
```

### Form Handling

```jsx
export default class Form extends React.Component {
  state = {
    title: "",
    text: "",
    library="React"
    isAwesome:true,
  };

  handleChange=(e)=>{
    if(e.target.type === "text"){
      this.setState({title:e.target.value});
    }
    else if(e.target.type === "textarea"){
      this.setState({text:e.target.value});
    }
    else if(e.target.type === "select-one"){
      this.setState({library:e.target.value});
    }
    else if(e.target.type === "checkbox"){
      this.setState({isAwesome:e.target.checked});
    }
    else{
      console.log("nothing here")
    }
  }

  submitHandler=(e)=>{
    e.preventDefault();
    // get the data from state
  }

  render() {
    const { title, text ,library,isAwesome} = this.state;
    return (
      <>
        <form onSubmit={this.submitHandler}>

          <input type="text" value={title}
          onChange={this.handleChange}
          />

          <textarea name="text" value={text}
            onChange={this.handleChange}
          ></textarea>

          <select value={library}
            onChange={this.handleChange}>
            <option value="React">React</option>
            <option value="Angular">Angular</option>
          </select>

          <input type="checkbox" checked={isAwesome}
            onChange={this.handleChange}/>

          <input type="submit" value="Submit" />
        </form>
      </>
    );
  }
}
```

### Higher Order Component

:File:HOC

##### withCounter.jsx(Pattern)

```jsx
import React from "react";

const withCounter = (OriginalComponent) => {
  class NewComponent extends React.Component {
    state = {
      count: 0,
    };

    incrementCount = () => {
      this.setState((prevState) => ({ count: prevState.count + 1 }));
    };

    render() {
      const { count } = this.state;
      return (
        <OriginalComponent count={count} incrementCount={this.incrementCount} />
      );
    }
  }
  return NewComponent;
};

export default withCounter;
```

:in actual component

##### ClickCounter.jsx

```jsx
import withCounter from "./HOC/withCounter";

const ClickCounter = (props) => {
  const { count, incrementCount } = props;
  return (
    <div>
      <button type="button" onClick={incrementCount}>
        Clicked {count} times
      </button>
    </div>
  );
};

export default withCounter(ClickCounter);
```

##### HoverCounter.jsx

```jsx
import withCounter from "./HOC/withCounter";

const HoverCounter = (props) => {
  const { count, incrementCount } = props;
  return (
    <div>
      <h1 onMouseOver={incrementCount}>Hovered {count} times</h1>
    </div>
  );
};

export default withCounter(HoverCounter);
```

### Render Prop

##### ClickCounter.jsx

```jsx
import React from "react";

export default function ClickCounter({ count, incrementCount }) {
  return (
    <div>
      <button type="button" onClick={incrementCount}>
        Clicked {count} times
      </button>
    </div>
  );
}
```

##### HoverCounter.jsx

```jsx
import React from "react";

export default function HoverCounter({ count, incrementCount }) {
  return (
    <div>
      <h1 onMouseOver={incrementCount}>Hovered {count} times</h1>
    </div>
  );
}
```

##### Counter.jsx(Pattern)

```jsx
import React from "react";

class Counter extends React.Component {
  state = {
    count: 0,
  };

  incrementCount = () => {
    this.setState((prevState) => ({ count: prevState.count + 1 }));
  };

  render() {
    const { children } = this.props;
    const { count } = this.state;
    return children(count, this.incrementCount);
  }
}

export default Counter;
```

##### App.jsx(Consumer)

```jsx
<Counter>
  {(counter, incrementCount) => (
    <ClickCounter count={counter} incrementCount={incrementCount} />
  )}
</Counter>
```

### Context API

##### creat your own

```js
// we obviously will use the built in react context api
class Context {
  constructor(value) {
    this.value = value;
  }

  // provider
  Provider = ({ children, value }) => {
    this.value = value;
    return children;
  };

  // consumer
  Consumer = ({ children }) => children(this.value);
}

function createContext(value = null) {
  const context = new Context(value);
  return {
    Provider: context.Provider,
    Consumer: context.Consumer,
  };
}

export default createContext;
```

##### Providing

```jsx
const themeContext = React.createContext();

state = {
  theme: "light",
  switchTheme: () => {
    this.setState(({ theme }) => {
      if (theme === "dark") {
        return {
          theme: "light",
        };
      }
      return {
        theme: "dark",
      };
    });
  },
};

<ThemeContext.Provider value={this.state}>
  <Section />
</ThemeContext.Provider>;
```

##### Consumer

```jsx

/************************************************************/
  //inside return

  <ThemeContext.Consumer>
  {
    ({theme,switchTheme})=>(
      <HoverCounter
        theme={theme}
        switchTheme={switchTheme}
      />
    )
  }
  </ThemeContext.Consumer>


/************************************************************/
  // outside return for class component

export default function Content(){
  const {theme,switchTheme}=this.context;
  render (){
    return(
      <></>
    )
  }
}

Content.contextType=ThemeContext


/************************************************************/
  // outside return for function component

import ThemeContext from "..."
export default function Content(){
  const {theme , switchTheme }=React.useContext(ThemeContext);
  return (
    <></>
  )
}

```

### useState

##### create your own useState

```jsx
const state = []; //[0:[value,setter],1:[value,setter]]
let stateIndex = -1;
function usesStat(defaultValue) {
  const index = ++stateIndex;
  if (states[index]) return states[index];

  const setValue = (newValue) => {
    states[index][0] = newValue;
    renderWithSumit();
  };

  const returnArray = [defaultValue.setValue];
  states[index] = returnArray;
  return returnArray;
}
function renderWithSumit() {
  stateIndex = -1;
  ReactDOM.render(<App />, document.getElementById("root"));
}
```

##### Rules

1.  must be declare in top level.Not even inside of if-statement or function
2.  setValue function wont merge the result.

##### syntax

```jsx
// declare
const [value, setValue] = React.useState({});

// change the value
setValue({ newValue });

// change the value depending the value of previous state
setValue((prevState) => {
  // modify the value of previous state
  return newValue;
});
```

##### fetching data from server

```jsx
import { useEffect, useState } from "react";

export default function GetPost() {
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [post, setPost] = useState({});

  useEffect(() => {
    fetch("https://jsonplaceholder.typicode.com/posts/1")
      .then((res) => res.json())
      .then((data) => {
        setLoading(false);
        setPost(data);
        setError("");
      })
      .catch((err) => {
        setLoading(false);
        setPost("");
        setError(err);
      });
    return () => {
      setLoading(true);
      setPost("");
    };
  }, []);

  return (
    <>
      {loading ? "loading" : post.title}
      {error || null}
    </>
  );
}
```

### useEffect

##### side effect

1.  Fetching Data
2.  Updating Dom
3.  Setting any Subscription
4.  Timer

##### syntax

```jsx
  useEffect(()=>{
    // calls in every render
  });

  useEffect(()=>{
    // calls if var changes any value
  },[var]);

  useEffect(()=>{
    // calls only once
  },[]);

  useEffect(()=>{
    return()=>{
      // if we return a function, then it will work like componentWillUnmount() lifecycle
    }
  },[var]);
```

### React.memo()

This is a Higher Order Component which works as componentShouldUpdate() lifecycle.

```jsx
function Title() {
  return <></>;
}

export default React.memo(Title);
```

### useCallback()

in normal call when we pass a function through props ,
its reference changes in every render and the new
component renders continously . to prevent this
unintentional rerender we can use this callack function.

```jsx
// cache a function body and remembers function reference
const incrementByOne = useCallback(() => {
  // remembers the function, only forget when the dependencies are being changed
}, [dependencies]);
```

### useMemo()

in some cases we dont need the value we got from a
functional component. to prevent this complication we
can remember the return value of that function and
can change it when we need to.

```jsx
const inEvenOdd = useMemo(() => {
  // remembers the return value , only forget when the dependencies are being changed
}, [dependencies]);
```

### useRef()

```jsx
//to make a reference for a particular element.
const inputRef = useRef(null);

useEffect(()=>{
  // the tag will store in the current object of the inputRef constant.
  inputRef.current.focus();
})

// reference must be declared in ref props of the targeted element
  <input ref={inutRef} type="text" placeholder="enter something" />


/************************************************************/

  // forwardRef()
  // passing a reference through a component
  // cannot pass a reference as we do for props

// in child component
function Input({type,placeholder},ref){
  return (
    <input ref={ref} type={type} placeholder={placeholder}/>
  )
}
const forwardedInput = React.forwardRef(Input)

export default forwardedInput;

/************************************************************/

  // useRef() as storage
  const inputRef = useRef(null);
  inputRef.current={dataYouWantToPut};
  // changing a state make a component
  //rerender but changing a reference value wont make this component rerender.
  // if in any case the component rerenders,
  //the value we set in a ref.current object wont be erased.

```

### UseReducer()

1. usage in state-management
2. alternative of useState()
3. useReducer(reducerFunc,initialSate)
4. newState=reducer(currentState,action)
5. returns a tuple - [newState,dispatch]

##### Pattern

```jsx
import {useReducer} from "react"

const initialState=0;
const reducer=(state,action)=>{
  // state is the current value of constant
  // action is a condition which decides what will be the next value of our state .

  switch(action){
    case ... :
      //
    case ...:
      //
    default:
      //
  }
}

export default function Red(){
  const [state, dispatch] = useReducer(reducer, initialState)
  // dispatch() takes the value of action.
  // state defines the value whice is returnd by the reducer function.
  // initially the value of state is the same of initialState we have set.
}
```

##### Fetching data

```jsx
import React,{ useEffect, userReducer } from "react";

const initialState={
  loading:true,
  error:"",
  post:{}
}

cosnt reducer=(state,action)=>{
  switch(action.type){
    case "SUCCESS":
      return{
        loading:false,
        post:action.result,
        error:""
      }
    case "ERROR":
      return{
        loading:false,
        post:{},
        error:"Something wrong"
      }
    default:
      return state;
  }
}

export default function GetPost() {
  const [state, dispatch] = useReducer(reducer, initialState)

  useEffect(() => {
    fetch("https://jsonplaceholder.typicode.com/posts/1")
      .then((res) => res.json())
      .then((data) => {
        dispatch({type:"SUCCESS",result:data})
      })
      .catch((err) => {

        dispatch({type:"ERROR"})
      });
    return () => {
      dispatch();
    };
  }, []);

  return(
    <>
      {state.loading?"loading":state.post.title}
      {state.error || null}
    </>
  )
}

```

### Custom Hook

// necessary to share logic
File: /src/hooks/useWindow.jsx

```jsx
import { useState, useEffect } from "react";

export default function useWindow(screenSize) {
  const [onSmallScreen, setOnSmallScreen] = useState(false);

  useeffect(() => {
    const checkScreenSize = () => {
      setOnSmallScreen(window.innerWidth < screenSize);
    };

    checkScreenSize();
    window.addEventListener("resize", checkScreenSize);

    return () => {
      window.removeEventListener("resize", checkScreenSize);
    };
  }, [screenSize]);

  return onSmallScreen;
}
```

// now by importing this function we can easily get the output what I desire.

### styling in React

```jsx

// inline insertion
  <p style={{color:"black",backgroundColor:"white"}}>
  </p>

// global import
  import "../App.css";
  export default function Ab(){
    return (
      <>
        <div className="logo"> logo </div>
      </>
    );
  }

// modular import
  import styles from "../Logo.module.css";
  export default function Ab(){
    return (
      <>
        <div className={style.logo}> logo </div>

        <div className={`${style.logo} border`}> logo </div>

        <div className={[style.logo, "border"].join(" ")}> logo </div>
        <- here logo is moduler css and border is global css ->

      </>
    );
  }
```

### css in js
