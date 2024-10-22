async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    const CustomERC1155 = await ethers.getContractFactory("CustomERC1155");
    const customERС1155 = await CustomERC1155.deploy(deployer.address);

    console.log("CustomERC1155 address:", await customERС1155.getAddress());

}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });