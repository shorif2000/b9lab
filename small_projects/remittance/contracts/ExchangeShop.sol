// library ExchangeShop

pragma solidity ^0.4.6;

library ExchangeShop{
    
    uint public constant conversionRate = 32; //for ether
    uint public constant commission = 1;
    uint public constant withdrawalFee = 5;
    
	function convertToLocalCurrency(uint amount)
	    constant
	    public
	    returns (uint convertedAmount)
	{
		return (amount * conversionRate) - commisionCharged(amount);
	}
	
	function commisionCharged(uint amount)
	    constant
	    public
	    returns(uint charged)
	{
	    return amount * commission;
	}
	
	function getConversionRate()
	    constant 
	    public
	    returns(uint conversionRate)
	{
	    return conversionRate;
	}
	
	function getcommission()
	    constant 
	    public
	    returns (uint commission)
	{
	    return commission;
	}
	
	function getWithdrawalFee()
	    constant 
	    public
	    returns (uint withdrawalFee)
	{
	    return withdrawalFee;
	}
	
	function takeWithdrawalFee(uint balance)
	    constant
	    public
	    returns (uint withdrawalFee)
	{
	    return balance - withdrawalFee;
	}
}