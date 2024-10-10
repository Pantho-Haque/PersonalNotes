bb# TypeScript

## Defination

1. _superset of js by microsoft_
2. _static strict typing_
3. _interface enumsn tuples , generics_
4. _compiletime error_

## Installation & setup

    1. npm i -g typescript
    2. tsc script.ts
    3. tsc --init
    4. go to tsconfig.js file
    5. "rootDir":"./src"
    6. "outDir":"./output"
    7. tsc (comand in terminal)
    8. tsc -w (whenever file saves the compilation repeats)

## Basics

    - when declare and assign -> ts strictly follow the type of allisned value
    - if not assigned -> the type will be (any)

## Explecit & union type

`let a: string` - explecit decaltion of a variable of type string </br>
`let a: string[]=[]` - array of string with declaration </br>
`let a:(string|number)[]=[]` - array of string or number </br>
`let a:object` - an object with any scheme (also accept array) </br>

<pre>
let a:{
    name:string,
    age:number,
    adult:boolean
}
<small>a fixed scheme where no new {key:value }cant be added</small>   
</pre>

## Dynamic type / Any type

`let a;` </br>
`let a:any` </br>
`let a:any[]=[]` - array of any type </br>

## Function type

<pre>
let myFunc : Function;
myFunc = () =>{
    // codes
}
</pre>
<pre>
const myFunc=(a:string,b:number,c?:string,d:string="hi") : number =>{
    // c is optional param
    // d has default value
    // function has return type number
}
</pre>

## Type alias

<pre>
type stringornum = string | number
type useType = {name:string , age: number}

const userDetails =(id: stringornum , use : userType)=>{}
const sayHello = (user:userType) => {}
</pre>

## Function signature

giving a structure to a function </br>
`let add: (a:number,b:number) => number` </br>

<pre>
add =(a:number,b:number)=>{
    // cant use extra parameter than the signature has
    // must return a number
    // return mothing means returning void
}
</pre>
