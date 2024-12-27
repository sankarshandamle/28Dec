const Web3 = require('web3');
const fs = require('fs');

const web3 = new Web3(new Web3.providers.HttpProvider('http://127.0.0.1:7545'));

async function deploy() {
    const accounts = await web3.eth.getAccounts();
    console.log('Accounts:', accounts);

    const balance = await web3.eth.getBalance(accounts[0]);
    console.log('Account 0 Balance:', web3.utils.fromWei(balance, 'ether'), 'ETH');

    // Load ABI and Bytecode
    const contractAbi = [
	{
		"inputs": [],
		"name": "getData",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_d",
				"type": "string"
			}
		],
		"name": "submitData",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	}
] 

    const bytecode = '608060405234801561001057600080fd5b50610334806100206000396000f3fe608060405234801561001057600080fd5b50600436106100365760003560e01c80633bc5de301461003b578063a2aac7ab146100be575b600080fd5b61004361018f565b6040518080602001828103825283818151815260200191508051906020019080838360005b83811015610083578082015181840152602081019050610068565b50505050905090810190601f1680156100b05780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b610177600480360360208110156100d457600080fd5b81019080803590602001906401000000008111156100f157600080fd5b82018360208201111561010357600080fd5b8035906020019184600183028401116401000000008311171561012557600080fd5b91908080601f016020809104026020016040519081016040528093929190818152602001838380828437600081840152601f19601f820116905080830192505050505050509192919290505050610231565b60405180821515815260200191505060405180910390f35b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156102275780601f106101fc57610100808354040283529160200191610227565b820191906000526020600020905b81548152906001019060200180831161020a57829003601f168201915b5050505050905090565b60008160009080519060200190610249929190610253565b5060019050919050565b828054600181600116156101000203166002900490600052602060002090601f01602090048101928261028957600085556102d0565b82601f106102a257805160ff19168380011785556102d0565b828001600101855582156102d0579182015b828111156102cf5782518255916020019190600101906102b4565b5b5090506102dd91906102e1565b5090565b5b808211156102fa5760008160009055506001016102e2565b509056fea2646970667358221220972ee618c2813cca0c923cd993f6bd72febe59960ecbe7a14f29dda8f4e59ffb64736f6c63430007060033'; 

    console.log('Deploying contract...');

    try {
        const testContract = new web3.eth.Contract(contractAbi);
        const contractInstance = await testContract
            .deploy({ data: bytecode })
            .send({ from: accounts[0], gas: '6000000' });
        console.log('Contract deployed successfully at address:', contractInstance.options.address);
        return contractInstance;
    } catch (error) {
        console.error('Error during contract deployment:', error);
    }

}

async function submitData(contractInstance, data) {
    const accounts = await web3.eth.getAccounts();
    try {
        // Call the submitData function on the contract
        const result = await contractInstance.methods.submitData(data).send({ from: accounts[0], gas: 2000000 });
        console.log('Data submitted successfully:', result);
    } catch (error) {
        console.error('Error submitting data:', error);
    }
}

// TODO: complete teh getData function
async function getData(contractInstance) {
    try {
        // Call the getData function to retrieve the stored data
        // Hint: await contractInstance.methods.<smart-contract-function-name>.call();
        // That's all!
        // store the return value in a variable called `result`

        // <<line goes here>>
        console.log('Stored Data:', result);
        return result;
    } catch (error) {
        console.error('Error retrieving data:', error);
    }
}

deploy().then(async (contractInstance) => {
    // Submit data
    await submitData(contractInstance, "Happy New Year!");

    // TODO: Retrieve the data
    // Hint: Use `await` and call the `getData` function with the `contractInstance` instance
    // store the return output in a variable called `data`

    // <add your code here>
    console.log('Data retrieved:', data);
}).catch(error => {
    console.error('Deployment failed:', error);
});
