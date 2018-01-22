// Splitter

pragma solidity ^0.4.6;

contract Splitter {
    
    address public alice;
    address public bob; 
    address public carol;
    
    struct SplitterStruct {
        address payee;
        uint amount;
    }
    
    mapping(address => uint) public recipientBalances;
    //$recipientBalances[$address] = $resultasuint
    
    
    function Splitter(address aliceAddress, address bobAddress, address carolAddress)
        public
    {
        require(aliceAddress != 0x0);
        require(bobAddress != 0x0);
        require(carolAddress != 0x0);
        require(aliceAddress != bobAddress);
        require(aliceAddress != carolAddress);
        require(bobAddress != carolAddress);
        alice = aliceAddress;
        bob = bobAddress;
        carol = carolAddress;
    }
    
    function split() 
        public 
        payable 
        returns(bool success)
    {
        require(msg.sender == alice);
        require(msg.value > 0);
        require(msg.value%2 == 0) ;
        
        recipientBalances[bob] += msg.value/2;
        //log here
        recipientBalances[carol] += msg.value/2;
        //log here
        
        return true;
    }
    
    function withdraw()
        public
        returns(bool success)
    {
        // check if balance in mapping and check sender exists
        require(recipientBalances[msg.sender] > 0 );//if(!recipientBalances[msg.sender]) throw;
        recipientBalances[msg.sender] = 0;
        // log event
        msg.sender.transfer(recipientBalances[msg.sender]);
        
        return true;
    }

    function kill() {
        if (msg.sender == alice) selfdestruct(owner);
    }
}
