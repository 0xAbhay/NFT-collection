const hre = require("hardhat");
const { ethers } = require("hardhat");

async function sleep(ms){
  return new Promise((resolve)=>setTimeout(resolve,ms));
}

async function main(){

  // here we deploy the contract
  const whitelistContract = await hre.ethers.deployContract("Whitelist" , [10]);
  // 10 is the max num of whitelist addresses allowed

  // wait for the contract to deploy
  await whitelistContract.waitForDeployment();

  //print the address of the deployed contract
  console.log("Whitelist Contract Address: ",whitelistContract.target);

    // Sleep for 30 seconds while Etherscan indexes the new contract deployment
    await sleep(30*1000); // 30s = 30*1000 milliseconds

    // verify contract on ether scan
    await hre.run("verify:verify",{
      address: whitelistContract.target,
      constructorArguments: [10],
    });
}

// Call the main function and catch if there is any error
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });