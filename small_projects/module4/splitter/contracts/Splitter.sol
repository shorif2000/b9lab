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
	
	mapping(address => uint) public recipientBalances;
	
	
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
		if(msg.value%2!=0) throw;
        if(!recipientBalances[bob].transfer(msg.value/2) && !recipientBalances[carol].transfer(msg.value/2)) throw;

        return true;
    }
    
    function checkBalance
        public
        constant
		returns(uint amount)
    {
        
    }
        
}
