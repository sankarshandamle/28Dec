pragma solidity >=0.7.0 <0.8.0;

contract collectEther {

   // A receive function to accept Ether with no data
   receive() external payable {
       // Ether is received without any specific logic
   }

   // Fallback function for other cases
   fallback() external payable {
       // Additional logic can be added here if needed
   }
}

// Inheriting the functions of base contract 
// collectEther through inheritance
contract sendEther is collectEther {
  
   collectEther cE;
   
   constructor() {
       cE = new collectEther();  // Creating a contract instance
   }

   function sendEtherTocE() public payable returns(bool) {
       address(cE).transfer(msg.value);
       return true;
   }

    // Function to send Ether to the fallback of cE
   function sendEtherToFallback() public payable returns (bool) {
       // Call cE with invalid function selector to trigger fallback
       (bool success, ) = address(cE).call{value: msg.value}("invalidFunctionCall");
       require(success, "Fallback call failed");
       return true;
   }

   function getBalancecE() public view returns(uint256) {
       return address(cE).balance;
   }

   function getAddress() public view returns(address) {
       return address(cE);
   }
}
