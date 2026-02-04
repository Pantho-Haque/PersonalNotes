# Solidity and Blockchain Notes

## Core Concepts

### Bytecode and ABI

- **Bytecode**: Public, immutable. The contract code executed on the EVM.
- **ABI (Application Binary Interface)**: A bridge between the application and the smart contract.
- _Note_: ABI and bytecode cannot be generated without the source code.

### Networks

- **Mainnet**
  - Transactions with real ETH.
  - Network ID: 1 (Ethereum).
- **Testnet**
  - Transactions with fake ETH.
  - Network IDs: 3, 4, 42 (e.g., Rinkeby test network).
- **JavaScript VM**
  - Transactions executed in a sandbox (memory blockchain).
  - Ideal for testing.

### Storage vs Memory

| Feature         | Storage               | Memory                      |
| :-------------- | :-------------------- | :-------------------------- |
| **Content**     | Holds state variables | Holds local variables       |
| **Persistence** | Persistent            | Not persistent              |
| **Gas Cost**    | Costs gas             | Does not cost gas (cheaper) |
| **Analogy**     | Like HDD              | Like RAM                    |

**Example:**

```solidity
string[] public student = ["ravi", "pantho", "nannu"];

function mem() public view {
    // Making a copy of the array (memory)
    string[] memory s1 = student;
    // Main array won't change
    s1[0] = "Akash";
}

function sto() public {
    // Making a reference of the array (storage)
    string[] storage s1 = student;
    // Main array WILL change
    s1[0] = "Akash";
}
```

## Visibility

| Accessibility    | Public | Private | Internal | External |
| :--------------- | :----: | :-----: | :------: | :------: |
| Outside          |   ✅   |   ❌    |    ❌    |    ✅    |
| Within Contract  |   ✅   |   ✅    |    ✅    |    ❌    |
| Derived Contract |   ✅   |   ❌    |    ✅    |    ✅    |
| Other Contracts  |   ✅   |   ❌    |    ❌    |    ✅    |

## Inheritance

```solidity
contract B is A {

}
```

## Contract Examples

### Identity Contract

```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.5.0 < 0.9.0;

contract Identity {
    string name;
    uint age;

    // Constructor: Executed once.
    // Use for initializing state variables or deciding the owner.
    constructor() {
        name = "Ravi";
        age = 17;
    }

    // View: No write for state variable (read allowed)
    function getName() view public returns(string memory) {
        return name;
    }

    // Pure: No read or write for state variable
    // view/pure functions do not require gas when called externally
    function getAge() view public returns(uint) {
        return age;
    }

    // State modifiers require gas
    function setAge() public {
        age = age + 1;
    }

    // Payable: Use whenever we have to send ether
    function payEth() public payable {
        // Function can receive ETH
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    // Transferring ETH
    address payable user1 = payable(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB);

    function sendToAcc() public {
        user1.transfer(1 ether);   // Sending 1 ETH to user1
    }
}
```

### State Variables, Arrays, and Loops

```solidity
// State variables
contract StateVarArrayLoop {
    // State Variables
    // Permanently stored in blockchain (contract storage), costs gas.
    // No NULL or NaN exists; automatically assigns default values.
    string name;
    uint age;

    // 'public' automatically creates a getter function
    uint public numb;

    // Local Variables
    function store() pure public returns(uint) {
        // Stored in stack, no gas for storage
        uint age = 10;

        // Use 'memory' for complex types (like string) to store in stack locally
        string memory name = "pantho";
        // 'memory' keyword cannot be used at the contract level for state variables

        return age;
    }

    // Enums
    enum User { Allowed, NotAllowed, Wait }
    User public u1 = User.Allowed; // returns 0
    User public u2 = User.Wait;    // returns 2

    /* Commands must be written inside of a function because a contract can't execute operations without them */

    // Arrays
    uint[4] public arrFixed = [10, 20, 30, 40];

    // Dynamic Arrays
    uint[] public arrDynamic;

    function arrayOperations() public {
        arrFixed.length; // Access length

        arrDynamic.push(1); // Add to end
        arrDynamic.length;
        arrDynamic.pop(); // Remove from end
    }

    // Bytes Arrays
    // Fixed size bytes are immutable (can't change single byte)
    bytes3 public b3 = "abc"; // 0x616263
    bytes2 public b2 = "ab";  // 0x6162
    // b3 = "a"; // 0x610000

     // Dynamic bytes array
    bytes public b1 = "abc";

    function bytesOperations() public {
        b1.push('d');
        // b1[index]; // access
        // b1.length;
    }

    // Loops
    function loopOps() public {
        uint count = 0;
        while(count < arrFixed.length) {
            arrFixed[count] = count;
            count++;
        }

        for(uint i = count; i < arrFixed.length; i++) {
            arrFixed[i] = i;
        }

        do {
            arrFixed[count] = count;
            count++;
        } while(count < arrFixed.length);
    }

    // Conditional Statements
    function check(uint a) public pure returns(bool) {
        bool value;
        if(a > 0) {
            value = true;
        } else {
            value = false;
        }
        return value;
    }

    // Mappings (Key => Value)
    // Key cannot be dynamic array, enum, struct. Value can be any type.
    // Stored in contract storage -> costs gas.
    mapping(uint => string) public roll;

    function setMap(uint keys, string memory value) public {
        roll[keys] = value;
    }
}
```

### Structs

```solidity
// Struct: Complex data type
// Can be created inside or outside of contract
struct Student {
    uint roll;
    string name;
}

contract Structure {
    Student public s = Student({
      roll: 12,
      name: "pantho"
    });

    function change(uint _roll, string memory _name) public {
        // Creating a memory struct (local)
        Student memory new_s = Student({
            roll: _roll,
            name: _name
        });

        // Assigning to state variable
        s = new_s;
    }
}
```

### Overflows

- **Batch Overflow**
- **Integer Overflow / Proxy Overflow**

```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.5.0;

contract ProxyOverflow {
    uint8 public money = 255;

    function setter() public {
        // Overflow happens here if money + 1 > 255
        // Result wraps around to 0
        money = money + 1;
    }
}
```
