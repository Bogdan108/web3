const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("CustomERC20 contract", function () {
    let CustomERC20, customERC20, owner, addr1, addr2;

    beforeEach(async () => {
        CustomERC20 = await ethers.getContractFactory("CustomERC20");
        [owner, addr1, addr2] = await ethers.getSigners();
        customERC20 = await CustomERC20.deploy(owner.address);
    });

    it("Should transfer tokens between accounts with comission", async () => {
        const addr1BalanceBeforeTransfer = await customERC20.balanceOf(addr1.address);
        expect(addr1BalanceBeforeTransfer).to.equal(0);
        await customERC20.transfer(addr1.address, 500);
        const addr1BalanceAfterTransfer = await customERC20.balanceOf(addr1.address);
        expect(addr1BalanceAfterTransfer).to.equal(475);
    });

    it("Should transferFrom tokens between accounts with comission", async () => {
        const addr1BalanceBeforeTransfer = await customERC20.balanceOf(addr1.address);
        expect(addr1BalanceBeforeTransfer).to.equal(0);
        await customERC20.approve(addr1.address, 500);
        await customERC20.connect(addr1).transferFrom(owner, addr1.address, 500);
        const addr1BalanceAfterTransfer = await customERC20.balanceOf(addr1.address);
        expect(addr1BalanceAfterTransfer).to.equal(475);
    });


    it("Should allow users to buy tokens via buyTokens function", async () => {
        const initialOwnerTokenBalance = await customERC20.balanceOf(owner.address);
        const tokenAmount = 10;
        await customERC20.connect(addr1).buyTokens({ value: tokenAmount });
        const finalBuyerTokenBalance = await customERC20.balanceOf(addr1.address);
        expect(finalBuyerTokenBalance).to.equal(tokenAmount);
    });

    it("Should fail when trying to buy less than 1", async () => {
        const excessiveAmount = 0;
        await expect(
            customERC20.connect(addr1).buyTokens({ value: excessiveAmount })
        ).to.be.revertedWith("Not valid tokens value");
    });
});