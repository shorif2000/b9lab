// Remittance

pragma solidity ^0.4.6;

import './ExchangeShop.sol';

contract Remittance {
    
    address public alice;
    address public bob; 
    address public carol;
    
    mapping (address => uint) balancesInLocalCurrency;
    mapping (address => bytes32) passwords;
    
    function Remittance(address aliceAddress, address bobAddress, address carolAddress)
        public
    {
        if(aliceAddress != 0x0) throw;
        if(bobAddress != 0x0) throw;
        if(carolAddress != 0x0) throw;
        if(aliceAddress != bobAddress) throw;
        if(aliceAddress != carolAddress) throw;
        if(bobAddress != carolAddress) throw;
        alice = aliceAddress;
        bob = bobAddress;
        carol = carolAddress;
    }
    
    //assume we are not storing ether and only in local currency
    function toBob(address receiver, uint amount)
        public
        payable
        returns(bool success)
    {
        if(msg.sender != alice) throw;
        if(receiver != bob) throw;
        if(amount == 0) throw;
        
        uint commisionCharged = ExchangeShop.commisionCharged(amount);
        //uint rate = ExchangeShop.getConversionRate();
        uint localCurrency = ExchangeShop.convertToLocalCurrency(amount);
        
        balancesInLocalCurrency[receiver] += localCurrency;
        balancesInLocalCurrency[carol] += commisionCharged;
        
        
        return true;
    }
    
    function setPassword(address reciepient, string password)
        public
        returns(bool hashPasswordSet)
    {
        bytes32 hash = generatePasswordHash(password);
        //log event
        passwords[reciepient] = hash;
        return true;
    }
    
    function generatePasswordHash(string password) 
        private 
        //pure 
        returns (bytes32)
    {
        return keccak256(password);
    }
    
    function withdraw(address carolAddress, string pass1, string pass2)
        public
        returns (bool success)
    {
        if(carolAddress != carol) throw;
        if(balancesInLocalCurrency[carol] == 0) throw;
        
        // compare passwords
        //get has of each
        bytes32 hash1 = generatePasswordHash(pass1);
        bytes32 hash2 = generatePasswordHash(pass2);
        if(passwords[bob] != hash1 || passwords[bob] != hash2) throw;
        if(passwords[carol] != hash1 || passwords[carol] != hash2) throw;
        
        //take withdrawal fee
        //log event
        balancesInLocalCurrency[bob] -= ExchangeShop.takeWithdrawalFee(balancesInLocalCurrency[bob]);
        //log event
        balancesInLocalCurrency[carol] += ExchangeShop.getWithdrawalFee();
        
        uint amountToSendCarol = balancesInLocalCurrency[carol];
        uint amountToSendBob = balancesInLocalCurrency[bob];
        
        // log event
        balancesInLocalCurrency[carol] = 0;
        balancesInLocalCurrency[bob] = 0;
        
        //log event
        if(!carol.send(amountToSendCarol)) throw;
        if(!bob.send(amountToSendBob)) throw;
        
        return true;
    }
}