pragma solidity ^0.4.13;

contract Owned {

    mapping (address => bool) private _owners;
    address private _masterAdmin;
    mapping (address => uint) private _balances;

    modifier isOwner() 
    {
        require(_masterAdmin == msg.sender || _owners[msg.sender]);
        _;
    }

    function Owned() 
        public
    {
       _masterAdmin = msg.sender;
       _owners[msg.sender] = true;
    }
/*
    function addOwner(string _addr)
        public
        //isOwner 
    {
        _owners[_addr] = true;
    }

    function removeOwner(string _addr)
        public
        //isOwner 
    {
        _owners[_addr] = false;
    }
*/

}