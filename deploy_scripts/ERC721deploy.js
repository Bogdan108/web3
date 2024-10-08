async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    const CustomERC721 = await ethers.getContractFactory("CustomERC721");
    const customERС721 = await CustomERC721.deploy(deployer.address);

    console.log("CustomERC721 address:", await customERС721.getAddress());

}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });