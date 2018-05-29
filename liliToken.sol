pragma solidity ^0.4.21;

import './zeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

contract liliToken is StandardToken {
    //StandardToken characteristics
    string public name = 'LILI'; 
    string public symbol = 'LIL';
    uint8 public decimals = 4;
    uint public INITIAL_SUPPLY = 36000000*(10**uint(decimals)); // 36 000 000 tokens with 4 decimals 
    
    address public liliAdminAddress;

    event TokensTransfered(address contributor, uint tokens);
    event Burn(uint256 value);
    
    modifier onlyAdmin {
        require(msg.sender == liliAdminAddress);
        _;
    }

    function isEqualLength(address[] x, uint[] y) internal returns (bool) { return x.length == y.length; }
    modifier onlySameLengthArray(address[] x, uint[] y) {
          require(isEqualLength(x,y));
          _;
    }


    function liliToken() public {
        liliAdminAddress = msg.sender;
        totalSupply_= INITIAL_SUPPLY;
        balances[liliAdminAddress] = INITIAL_SUPPLY;
    }
    

    //Distribute tokens at multiple addresses in one function call (only accessible by the lili admin)
    function distributeTokens(address[] _contributors, uint[] _tokenAmounts) public onlyAdmin onlySameLengthArray(_contributors, _tokenAmounts) {
        for (uint i = 0; i < _contributors.length; i++) {
            transfer(_contributors[i], _tokenAmounts[i]);
            TokensTransfered(_contributors[i],_tokenAmounts[i]);
            }
        }

    // At the end of the ICO, unused tokens will be burned by the lili admin.
    function burn(uint256 _value) public onlyAdmin {
        require(_value <= balances[liliAdminAddress]);
        balances[liliAdminAddress] = balances[liliAdminAddress].sub(_value);
        totalSupply_ = totalSupply_.sub(_value);
        Burn(_value);
        Transfer(liliAdminAddress, address(0), _value);
    }

}