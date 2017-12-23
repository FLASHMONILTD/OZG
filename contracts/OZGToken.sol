pragma solidity ^0.4.15;
import "./Ownable.sol";
import "./SafeMath.sol";

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract OZGToken is Ownable {

	/* This is not an ERC20 token */
	string public constant name      = "OZGToken";
	string public constant symbol    = "OZG";
	uint256 public constant MAX_SUPPLY_NBTOKEN    = 3650000;
	
	uint256 public START_ICO_TIMESTAMP = 1501595111; // not constant for testing (overwritten in the constructor)
	
	uint256 public assignedSupply;
	bool public batchAssignStopped = false;

	//uint oneTokenWeiPrice;
	//uint minEthWeiToBuy;

	address[] addrbalances;
	mapping (address => uint256) ozgbalances;

	function OZGToken() {

		owner = msg.sender;
		// assign token to owner
		ozgbalances[owner] = 9999999; 		//!!!tmp to set properly before production deploy 
		ozgbalances[0x111111111] = 9999999; //!!!tmp to set properly before production deploy 
		ozgbalances[0x111111122] = 9999999; //!!!tmp to set properly before production deploy 
		ozgbalances[0x111111133] = 9999999; //!!!tmp to set properly before production deploy 
		assignedSupply       = 999999;		//!!!tmp to calc set properly before production deploy 

		START_ICO_TIMESTAMP = now; /// !!!tmp
	}	

	function getStartIcoTimestamp() constant returns (uint256){
			return START_ICO_TIMESTAMP;
	}

	function getBlockTimestamp() constant returns (uint256) {
			return now;
	}

	function getBlockNumber() constant returns (uint256) {
			return block.number;
	}

	/*
	Serge a validé le fait qu'on écrit en dur dans le constructeur les peux d'adresses (<10) qui vont posséder des OZG 
	
	function batchAssignTokens(address[] _vaddr, uint[] _vamounts) onlyOwner {

			require ( batchAssignStopped == false );
			require ( _vaddr.length == _vamounts.length);

			//Looping into input arrays to assign target amount to each given address
      		for (uint index=0; index<_vaddr.length; index++) {

          		address toAddress = _vaddr[index];
          		uint amount = _vamounts[index];
          		if (ozgbalances[toAddress] == 0) { // attention le file text ne doit pas avoir de doublons !
					ozgbalances[toAddress] = amount;
					assignedSupply += amount;							
				}				
			}
			// owner keeps all unassigned tokens 
			uint256 ownerAmount = MAX_SUPPLY_NBTOKEN - assignedSupply;
			ozgbalances[owner] = ownerAmount;
	}*/

	function getAddressBalance(address addr) constant returns (uint256 balance)  {
		balance = ozgbalances[addr];
	}

	function getAddressAndBalance(address addr) constant returns (address _address, uint256 _amount)  {
		_address = addr;
		_amount = ozgbalances[addr];
	}

	// Serge a validé le fait que cette fonction est la seule à mettre: 
	// seul le owner peut donner ses OZG (mais pas les récupérer)
	// tous les autres adresses sont figés à jamais
	function transfertOZGTokens(address receiver, uint256 numTokens) onlyOwner {
		require(numTokens > 0);
		require(ozgbalances[owner] >= numTokens);
		ozgbalances[owner] = ozgbalances[owner] - numTokens;
		ozgbalances[receiver] = ozgbalances[receiver] + numTokens;
	}

	function killContract() onlyOwner {
		suicide(owner);
	}
}


