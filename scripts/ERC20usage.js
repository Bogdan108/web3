
async function main() {
    try {
        const token = await ethers.getContractFactory("CustomERC20");
        const [owner, addr1, addr2] = await ethers.getSigners();

        const contractAddr = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
        const contract = await token.attach(contractAddr);

        await contract.transfer(addr1.address, 50000000n);

        await contract.approve(addr1.address, 50000000000000000000n);
        await contract.connect(addr1).transferFrom(owner.address, addr1.address, 50000000000000000000n);

        await contract.buyTokens({ value: 10000000n });

        ownerBalance = await contract.balanceOf(owner.address);
        addr1Balance = await contract.balanceOf(addr1.address);

        console.log(ownerBalance);
        console.log(addr1Balance);
        console.log(owner.address);
        console.log(addr1.address);


    } catch (error) {
        console.error(error);
        process.exit(1);
    }
}

main();