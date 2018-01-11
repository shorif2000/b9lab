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
		let bobBeforeBalance, carolBeforeBalance;
		let bobAfterBalance, carolAfterBalance;
		return contract.recipientBalances(bob)
		.then(function(_recipientBalances) {
			bobBeforeBalance = _recipientBalances;
			return contract.recipientBalances(carol);
		})
		.then(function(_recipientBalances) {
			carolBeforeBalance = _recipientBalances;
			return contract.split({from: alice, value: 2});
		})
		.then(response => {
			return contract.recipientBalances(bob);
		})
		.then(function(_recipientBalances) {
			bobAfterBalance = _recipientBalances;
			return contract.recipientBalances(carol);
		})
		.then(function(_recipientBalances) {
			carolAfterBalance = _recipientBalances;
			//return contract.split({from: alice, value: 2});
			assert(bobBeforeBalance > bobAfterBalance,"Bob balance " + bobBeforeBalance + "is same " + this.recipientBalances[bob]);
			assert(carolBeforeBalance,carolAfterBalance,"Carol balance is same");
			
		});
	});

});
