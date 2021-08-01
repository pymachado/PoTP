// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract tokenFactory is ERC1155, AccessControl {
  using Counters for Counters.Counter;
  Counters.Counter public hightToken; 

  mapping (uint256 => mapping(address => bytes)) public verificationOf; 

//Set the general URI inside ERC1155's constructor 
  constructor() ERC1155("RESERVA TOKEN FACTORY") {
    super._setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
  }

  function supportsInterface(bytes4 interfaceId) public view virtual override(ERC1155, AccessControl) returns (bool) {
    return this.supportsInterface(interfaceId);
  }

  function createYield(
    bytes memory _pova,
    uint256 _amount, 
    address _addressGrower) external onlyRole(DEFAULT_ADMIN_ROLE) returns (bool) {
      hightToken.increment();
      uint256 newItemId = hightToken.current();
      verificationOf[newItemId][_addressGrower] = _pova;
      _mint(_addressGrower, newItemId, _amount, _pova);
      return true;
    }

  function burnYield(address _grower, uint256 _tokenId, uint256 _amount) external returns (bool) {
    _burn(_grower, _tokenId, _amount);
    return true;
  }  
}
