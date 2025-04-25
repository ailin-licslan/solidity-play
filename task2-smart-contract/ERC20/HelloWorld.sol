// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

contract HelloWorld {
    constructor(){

    }
    string public greeting = "Hello World";
    int public a = 30;
    int public b=10;
    int[] public arr1;
    bool[] public arr2;
    address[] public arr3;
    struct Person{
        uint8 age;
        string name;
        bool gender;
    }
    Person public person1 = Person(23,"A",true);
    Person public person2 =Person({age:45,name:"B",gender:false});

    function setNum(int c) public view returns (int){
        //return a + b + c ;
        return setNum2(c);
    }

    //public修饰时都可见
    function setNum2(int c) public view returns (int){
        return a + b + c ;
    }

    //external修饰时 当前合约 & 子合约不可见   外部账户 其他合约是可见的
    function setNum3(int c) external view returns (int){
        return a + b + c ;
    }

    //private修饰时 仅当前合约可见
    function setNum4(int c) private  view returns (int){
        return a + b + c ;
    }

    //internal修饰时 当前合约 & 子合约可见   外部账户 其他合约是不可见的
    function setNum5(int c) internal  view returns (int){
        return a + b + c ;
    }

    //pure 不能写 不能读
    function concat(string memory name, string memory xxx) public pure returns (string memory) {
        return string.concat(name, xxx);
    }

    //view修饰 可读变量 greeting
    function concat2() public view returns (string memory) {
        return string.concat("xxx", greeting);
    }

    enum status{
        Inactive,
        Active
    }
}