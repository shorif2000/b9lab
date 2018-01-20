pragma solidity ^0.4.6;

contract Victim{
    uint public owedToAttacker;
    
    function Victim()
    {
        owedToAttacker = 11;
    }
    
    function withdraw()
    {
        if(!msg.sender.send(owedToAttacker)) throw;
        owedToAttacker = 0;
    }
    
    function deposit() 
        payable
    {
        
    }
}
