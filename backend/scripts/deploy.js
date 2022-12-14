const {ethers} = require("hardhat");

async function main() {
  /*
  A ContractFactory in ethers.js is an abstraction used to deploy new smart contracts,
  so whitelistContract here is a factory for instances of our Whitelist contract.
  */
  const buyMeADrink = await ethers.getContractFactory("BuyMeADrink");
  const buyMeADrinkDdeployed = await buyMeADrink.deploy();
  await buyMeADrinkDdeployed.deployed();

  console.log(
    "Whitelist Contract Address:",
    deployedWhitelistContract.address
  );
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });