
async function main() {
    try {
        // your token name 
        const token = await ethers.getContractFactory("CustomERC20");
        // your token address 
        const contractAddr = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
        const contract = await token.attach(contractAddr);

        for (let storageSlot = 0; storageSlot < 10; storageSlot++) {
            console.log(await ethers.provider.getStorage(contractAddr, storageSlot));
        }

    } catch (error) {
        console.error(error);
        process.exit(1);
    }
}

main();
