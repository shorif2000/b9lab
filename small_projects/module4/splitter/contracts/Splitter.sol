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
	//$recipientBalances[$address] = $resultasuint
	
	
    function Splitter(address bobAddress, address carolAddress)
        public
    {
        require(bobAddress != 0x0);
        require(carolAddress != 0x0);
        require(bobAddress != carolAddress);
        bob = bobAddress;
        carol = carolAddress;
    }
    
    function split() 
        public 
        payable 
        returns(bool success)
    {
        require(msg.value > 0);
		require(msg.value%2 == 0) ;
		
		recipientBalances[bob] += msg.value/2;
		//log here
		recipientBalances[carol] += msg.value/2;
		//log here
		
        //bob.transfer(msg.value/2);
        //carol.transfer(msg.value/2);

        return true;
    }
    
    function withdraw()
        public
       // payable
        returns(bool success)
    {
        // check if balance in mapping
        require(recipientBalances[msg.sender] > 0 );//if(!recipientBalances[msg.sender]) throw;
        // check sender exists
        // reset balance to 0
        // log event
        msg.sender.transfer(recipientBalances[msg.sender]);
        
        return true;
    }
    
    function checkBalance()
        public
        constant
		returns(uint amount)
    {
        return recipientBalances[msg.sender];
    }
        
}
