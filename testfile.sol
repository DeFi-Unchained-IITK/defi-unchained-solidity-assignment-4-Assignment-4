// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/forge-std/src/Test.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";
import "./ERC20.sol"; 

contract MyNFTTest is Test {
    MyNFT public myNFT;
    address public owner = address(1);
    address public recipient = address(2);

    function setUp() public {
        vm.prank(owner); 
        myNFT = new MyNFT();
    }

    function testInitialOwner() public {
        assertEq(myNFT.owner(), owner);
    }

    function testMinting() public {
        vm.prank(owner); 
        uint256 tokenId = myNFT.mint(recipient);

        assertEq(myNFT.ownerOf(tokenId), recipient);
        assertEq(myNFT.balanceOf(recipient), 1);
    }

    function testSafeTransferFromWithBytes() public {
        vm.prank(owner); 
        uint256 tokenId = myNFT.mint(recipient);

        vm.prank(recipient);
        bytes memory data = abi.encodePacked("transfer data");
        myNFT.safeTransferFrom(recipient, owner, tokenId, data);

        assertEq(myNFT.ownerOf(tokenId), owner);
    }

    function testSafeTransferFromWithoutBytes() public {
        vm.prank(owner); 
        uint256 tokenId = myNFT.mint(recipient);

        vm.prank(recipient); 
        myNFT.safeTransferFrom(recipient, owner, tokenId);

        assertEq(myNFT.ownerOf(tokenId), owner);
    }

    function testTransferFrom() public {
        vm.prank(owner); 
        uint256 tokenId = myNFT.mint(recipient);

        vm.prank(recipient);
        myNFT.transferFrom(recipient, owner, tokenId);

        assertEq(myNFT.ownerOf(tokenId), owner);
    }

    function testApproval() public {
        vm.prank(owner); 
        uint256 tokenId = myNFT.mint(recipient);

        vm.prank(owner);
        address approved = address(3);
        myNFT.approve(approved, tokenId);

        assertEq(myNFT.getApproved(tokenId), approved);
    }

    function testSetApprovalForAll() public {
        vm.prank(owner);
        address operator = address(4);
        myNFT.setApprovalForAll(operator, true);

        assertTrue(myNFT.isApprovedForAll(owner, operator));
    }

}
