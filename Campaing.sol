// Contract Factory Practice

pragma solidity ^0.4.6;

contract Campaign {
    
    address public owner;
    uint    public deadline; //block number
    uint    public goal; //wei
    uint    public fundsRaised;
    
    function contribute() public payable returns(bool success){
        
    }
    
    function withdrawFunds() public returns (bool success){
        
    }
    
    function sendRefunds() public returns (bool success){
        
    }
}
