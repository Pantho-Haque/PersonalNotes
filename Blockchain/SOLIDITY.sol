/*


bytecode is public but contract must not 
bytecode is immutable
ABI is a bridge btwn app and smartcontract
ABI and bytecode cant be generated without source code


mainnet
-transaction with real ETH
-network id 1
-Ethereum

testnet
-transaction with fake ETH
-network id 3,4,42
-Rinkyby test network


JavaScript VM
- transaction will be executed in sandbox
- on memory blockchain
- ideal for testing

Injected Web3
Web3 provider
        
        
        storage         |       memory
    
    holds state variable|   holds local variable
    persistent          |   not
    costs gas           |   not
    like HDD            |   like RAM

string[] public student=["ravi","pantho","nannu"];
function mem() public view {
    string[] memory s1 = student;       -> making a copy of the array of a string 
    s1[0]="Akash";                      -> main array wont change
}

function sto() public{
    string[] storage s1=student;       -> making a reference of the array of a string 
    s1[0]="Akash";                      -> main array will change
}


visibility
                    public      private     internal        external

                    outside         x           x           outside
can access          within        within     within             x       of the contract
                    derived         x       derived         derived
                    other           x           x           other

inherit
contract B is A{
    
}

*/

// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 < 0.9.0; 

contract Identity
{
    string name;
    uint age;
    // once execution
    // use  - initializing the state variables]
    //      - decide the owner of contract
    constructor()
    {
        name="Ravi";
        age=17;
    }


    // when we dont modify state variable , we use view or pure
    // pure - no read or write for state variable
    // view - no write for state variable(read allowed)
    function getName() view public returns(string memory)
    {
        return name;
    }

    // no gas required for getter function 
     function getAge() view public returns(uint)
    {
        return age;
    }

    // we have to pay gas for setter function 
     function setAge() public
    {
        age=age+1;
    }

    // payable function 
    // use "payable" keyword whenever we have to send ether
    function payEth() public payable{
        // returns a value of wei form
        // send eth to contract
    }
    
    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    // will transfer ETH to this account
    address payable user1=payable(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB);
    function sendToAcc() public {
        user1.transfer(1 ether);   // sending 1 eth to user1
    }


}

// State variables
contract StateVarArrayLoop
{
    string name;
    uint age;
    // this is a state variable
    // permanently store in blockchain(contract storge), so we have to pay gas to store it
    // more state variable => more gas
    // no NULL or NaN exists, automatically asigns a value in state variable 
    uint public numb;
    // adding public in front of any variable or function will automatically create a get function for it

    // Local variable 
    // pure - let us know that this fucntion wont modify any static variiable
    function store() pure public returns(uint)
    {
        uint age=10;
        // store in stack
        // no gas storage
        string memory name="pantho";
        // by default string type variable stores in contract storage 
        // to declare it as local variable we have to use "memory" keyword so that it stores in stack
        // memory keyword cant be used in contract level.
      

        return age;
    }

    // enum
    enum user={allowed, not_allowed,wait}
    user public u1= user.allowed; // return 0;
    user public u2= user.wait; // return 2;



    /* commands must write iside of a function cause a class cant execute any opertion without functions */

    // array 
    uint[4] public arr=[10,20,30,40];
    arr.length;

    // dynamic size array
    uint[] public arr;
    arr.push(value);
    arr.length;
    arr.pop();

    // bytes array 
    // immutable-> cant change the value of any particulat index-> single bytes cant be changed 
    bytes3 public b3;
    b3 ="abc"; // 0x616263
    b3="a";    // 0x610000
    bytes2 public b2;
    b2 ="ab"; // 0x6162

     // dynamic bytes array 
    bytes public b1="abc";
    b1.push('d');
    b1[index];
    b1.length;


    // loop 
    uint count;
    while(count<arr.length){
        arr[count]=count;
        count++;
    }
    for(uint i=count ; i<arr.length;i++){
        arr[count]=count;
        count++;
    }
    do{
        arr[count]=count;
        count++;
    }while(count<arr.length)


    // conditional statement
    function check(uint a) public pure returns(bool){
        bool value;
        if(a>0){
            value =true;
        }else{
            value=false;
        }
        return value;
    }



    // mappuing(key->value)
    // key cant be dynamic array,enum,struct
    // value can be any type
    // store in contract storage -> costs gas
    mapping(uint=>string) public roll;
    function setMap(uint keys,string memory value) public{
        roll[keys]=value 
    }
}

// complex datatype
// can be create inside or outside of contract storage
// storage type variable(as like as string) -> to use locally we have to use "memory" keyword 
struct Student{
    uint roll;
    string name;
}

contract structure{
    Student public s= Student({
      roll:12,
      name:"pantho"
    });
    function change(uint _roll ,string memory _name) public{
      Student memory new_s= Student({
        roll:_roll,
        name:_name
      });
      s=new_s;
    }
}

// local variables
contract Local
{
    
}



// batch overflow

// integer overflow / proxy overflow

// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.5.0 ; 
contract ProxyOverflow
{
    uint8 public money=255;

    function setter() public{
        momey=money+1;
    }
}