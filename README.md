# Assignment 04 

In this assignment, you have to implememnt ERC 721 protocol for NFTs. You have to implement all these functions :

    
  ## Solidity Function Declarations

```solidity
function balanceOf(address _owner) external view returns (uint256);
function ownerOf(uint256 _tokenId) external view returns (address);
function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable;
function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
function approve(address _approved, uint256 _tokenId) external payable;
function setApprovalForAll(address _operator, bool _approved) external;
function getApproved(uint256 _tokenId) external view returns (address);
function isApprovedForAll(address _owner, address _operator) external view returns (bool);
```
Also you have to use the following events : 

```solidity
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
```
Make a basic test file of these functions performing unit tests.

You have to code in VS code. Clone your repository using VS code, ensure that the cloned repository is in the main branch. Make the changes and push the file in your github repo after
committing the changes.


    

    
