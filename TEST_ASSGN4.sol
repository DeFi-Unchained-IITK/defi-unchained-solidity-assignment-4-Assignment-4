const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MyERC721", function () {
  let MyERC721, myERC721, owner, addr1, addr2;

  beforeEach(async function () {
    [owner, addr1, addr2] = await ethers.getSigners();
    MyERC721 = await ethers.getContractFactory("MyERC721");
    myERC721 = await MyERC721.deploy("MyToken", "MTK");
    await myERC721.deployed();

    await myERC721._mint(owner.address, 1);
    await myERC721._mint(owner.address, 2);
    await myERC721._mint(owner.address, 3);
  });

  describe("Deployment", function () {
    it("Should set the right owner", async function () {
      expect(await myERC721.ownerOf(1)).to.equal(owner.address);
    });

    it("Should assign the total supply of tokens to the owner", async function () {
      const ownerBalance = await myERC721.balanceOf(owner.address);
      expect(await myERC721.balanceOf(owner.address)).to.equal(3);
    });
  });

  describe("Transactions", function () {
    it("Should transfer tokens between accounts", async function () {
      await myERC721.transferFrom(owner.address, addr1.address, 1);
      expect(await myERC721.ownerOf(1)).to.equal(addr1.address);

      await myERC721.connect(addr1).transferFrom(addr1.address, addr2.address, 1);
      expect(await myERC721.ownerOf(1)).to.equal(addr2.address);
    });

    it("Should approve and then transfer tokens between accounts", async function () {
      await myERC721.approve(addr1.address, 2);
      await myERC721.connect(addr1).transferFrom(owner.address, addr2.address, 2);
      expect(await myERC721.ownerOf(2)).to.equal(addr2.address);
    });

    it("Should set approval for all", async function () {
      await myERC721.setApprovalForAll(addr1.address, true);
      expect(await myERC721.isApprovedForAll(owner.address, addr1.address)).to.be.true;

      await myERC721.connect(addr1).transferFrom(owner.address, addr2.address, 3);
      expect(await myERC721.ownerOf(3)).to.equal(addr2.address);
    });
  });
});
