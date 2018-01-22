// Splitter

pragma solidity ^0.4.13;

import "..//library/Owned.sol";

contract Splitter is Owned {
    
    address public alice;
    address public bob; 
    address public carol;
    //address public owner;
    
    uint public totalSplitterBalance = 0;

    
    mapping(address => uint) public recipients;
    //$recipientBalances[$address] = $resultasuint

    function addReciepient(address _recipient)
        public
        returns(bool addedReciepent)
    {
        require(recipients.length < 2);
        recipients[_recipient] = 0;
        return true;
    }
    
    function split() 
        public 
        payable 
        returns(bool success)
    {
        require(msg.sender == isOwner());
        require(msg.value > 0);
        require(msg.value%2 == 0) ;
        require(recipients.length == 2) ;
        
        for(uint i=0; i < recipients.length;i++){
            recipients[i] = msg.value/2;
            //log here
            // store total
            totalSplitterBalance += msg.value;
        }
        
        return true;
    }
    
    function withdraw()
        public
        returns(bool success)
    {
        // check if balance in mapping and check sender exists
        require(recipients[msg.sender] > 0 );//if(!recipientBalances[msg.sender]) throw;
        recipients[msg.sender] = 0;
        // log event
        msg.sender.transfer(recipients[msg.sender]);
        
        // remove from total
        totalSplitterBalance += recipients[msg.sender];
        
        return true;
    }
}
