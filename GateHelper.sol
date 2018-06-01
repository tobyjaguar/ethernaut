pragma solidity ^0.4.18;

interface GatekeeperOne {
      modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    require(msg.gas % 8191 == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint32(_gateKey) == uint16(_gateKey));
    require(uint32(_gateKey) != uint64(_gateKey));
    require(uint32(_gateKey) == uint16(tx.origin));
    _;
  }
  
    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool);
}

contract GateHelper {
    uint public constant remainder = 8191;
    address public owner;
    GatekeeperOne gatekeeper;
    
    constructor(address _contract) public {
        owner = msg.sender;
        gatekeeper = GatekeeperOne(_contract);
    }
    
    function callContract(bytes4 _method, bytes8 _key, uint _gas) public returns (bool, uint, uint) {
        bool didWeWin;
        uint initialGas;
        uint finalGas;
        initialGas = gasleft();
        didWeWin = gatekeeper.call.gas(_gas)(_method, _key);
        finalGas = gasleft();
        return (didWeWin, initialGas, finalGas);
    }
    
    function giveConversions(bytes8 _key) public view returns (uint16, uint32, uint64, uint16) {
        return (uint16(_key), uint32(_key), uint64(_key), uint16(tx.origin));
    }
    
    function giveOrigin() public view returns (address) {
        return tx.origin;
    }
    
    function giveOriginUint16() public view returns (uint16) {
        return uint16(tx.origin);
    }
    
    function giveOriginUint32() public view returns (uint32) {
        return uint32(tx.origin);
    }
    
    function giveOriginBytes8() public view returns (bytes8) {
        return bytes8(tx.origin);
    }
    
    function giveBytes8of16(uint16 _input) public view returns (bytes8) {
        return bytes8(_input);
    }
    
    function giveBytes8of32(uint32 _input) public view returns (bytes8) {
        return bytes8(_input);
    }
    
    function giveKeccak(string _input) public pure returns (bytes4) {
        return bytes4(keccak256(_input));
    }
    
    function kill() public {
        require(owner == msg.sender);
        selfdestruct(owner);
    }
}
