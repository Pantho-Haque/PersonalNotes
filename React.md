- [installation](#installation)
- [Router setup](#router-setup)
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
- [useEffect](#useeffect)
    - [side effect](#side-effect)
    - [syntax](#syntax-1)

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
  function ab() {}
  const bc = () => {};
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