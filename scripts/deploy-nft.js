const hre = require("hardhat");

async function sleep(ms){
  return new Promise((resolve)=>setTimeout(resolve, ms));
}

async function main(){

  // deploy the contact
  const nftContract  = await hre.ethers.deployContract("NFTee",[
    "0x8839898B9216A1015f095aF6782Ded9A14e11a50",
  ]);

  // wait for the contract to deploy
  await nftContract.waitForDeployment();

  // address of the nft contract
  console.log("NFTee CONTRACT Address:",nftContract.target);

  await sleep(30 * 1000); // 30s = 30 * 1000 milliseconds

  // Verify the contract on etherscan
  await hre.run("verify:verify", {
    address: nftContract.target,
    constructorArguments: ["0x8839898B9216A1015f095aF6782Ded9A14e11a50"],
  });
  
}


// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
