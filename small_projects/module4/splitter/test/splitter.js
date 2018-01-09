var Splitter = artifacts.require("./Splitter.sol");

contract('Splitter', function(accounts) {

	var contract;
	var alice = accounts[0];
	var bob = accounts[1];  
  	var carol = accounts[2];

	beforeEach(function(){
	    return Splitter.new(alice, bob, carol)
	    .then(function(instance)  {
	     	contract = instance;	      
	    });
	});

	it("should check split function", function() {
		var bobBeforeBalance = contract.recipientBalances[bob];
		var carolBeforeBalance = contract.recipientBalances[carol];
		return contract.split({from: alice, value: 2})
		.then(function(_recipientBalances) {
			assert(bobBeforeBalance > this.recipientBalances[bob],"Bob balance " + bobBeforeBalance + "is same " + this.recipientBalances[bob]);
			assert.greaterThan(carolBeforeBalance,_recipientBalances[carol],"Carol balance is same");
			return true;
		});
	});

});
