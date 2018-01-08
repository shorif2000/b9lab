// Splitter

pragma solidity ^0.4.6;

contract Splitter {
    
    address public bob; 
    address public carol;
    uint public bobAmount;
    uint public carolAmount;
    
    struct SplitterStruct {
        address payee;
        uint amount;
    }
    
    SplitterStruct[] public splitStructs;
    
    function Splitter(address bobAddress, address carolAddress){
        bob = bobAddress;
        carol = carolAddress;
    }
    
    function split() 
        public 
        payable 
        returns(bool success)
    {
        if(msg.value==0) throw;
        if(!bob.send(msg.value/2) && !carol.send(msg.value/2)) throw;
        SplitterStruct memory newPayment;
        newPayment.payee = bob;
        newPayment.amount = msg.value/2;
        splitStructs.push(newPayment);
        newPayment.payee = carol;
        newPayment.amount = msg.value/2;
        splitStructs.push(newPayment);
        return true;
    }
    
    function checkBalance
        public
        constant
    {
        
    }
        
}
