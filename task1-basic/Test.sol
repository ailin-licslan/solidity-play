// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;


contract Test{

    uint public c ;
    uint public a = 10;
    uint public b  = 1;
    address public owner;


    uint256[] public uint256Array = [1, 2, 3];
    string[] public stringArray = ["apple", "banana", "carrot"];
    string[] public values;
    uint256[][] public array2D = [[1, 2, 3], [4, 5, 6]];


    mapping(uint256 => string) public names;
    mapping(uint256 => Book) public books;
    mapping(address => mapping(uint256 => Book)) public myBooks;
    uint256[] public numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    constructor(){
        owner=msg.sender;
        a = 20;
    }





    function countEvenNumbers() public view returns (uint256) {
        uint256 count = 0;

        for (uint256 i = 0; i < numbers.length; i++) {
            if (isEvenNumber(numbers[i])) {
                count++;
            }
        }

        return count;
    }

    function isEvenNumber(uint256 _number) public pure returns (bool) {
        if (_number % 2 == 0) {
            return true;
        } else {
            return false;
        }
    }


    struct Book {
        string title;
        string author;
    }

    constructor() {
        names[1] = "Adam";
        names[2] = "Bruce";
        names[3] = "Carl";
    }

    function addBook(
        uint256 _id,
        string memory _title,
        string memory _author
    ) public {
        books[_id] = Book(_title, _author);
    }

    function addMyBook(
        uint256 _id,
        string memory _title,
        string memory _author
    ) public {
        myBooks[msg.sender][_id] = Book(_title, _author);
    }





    function addValue(string memory _value) public {
        values.push(_value);
    }

    function valueCount() public view returns (uint256) {
        return values.length;
    }

    function getInt() view public returns (uint){
        return b;
    }

    function setInt2(uint _e) public{
        b = b+_e;
    }

    //only calculate in function local var
    function setInt(uint _b) pure public returns (uint) {
        return  (_b + 20);
    }

    function setValue(uint _c) public {
        c = _c;
    }

    function isOwner() public view returns (bool) {
        return (msg.sender == owner);
    }




}