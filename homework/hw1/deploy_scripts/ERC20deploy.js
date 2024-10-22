
async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    const CustomERC20 = await ethers.getContractFactory("CustomERC20");
    const customERC20 = await CustomERC20.deploy(deployer.address);

    console.log("CustomERC20 address:", await customERC20.getAddress());
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });