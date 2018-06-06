pragma solidity ^0.4.18;

interface GatekeeperTwo {

  function enter(bytes8 _gateKey) public returns (bool);

}

contract GateHelper2 {
    uint public data;
    address public owner;
    GatekeeperTwo gatekeeper;

    constructor(address _contract) public {
        owner = msg.sender;
        gatekeeper = GatekeeperTwo(_contract);
    }

    function callContract(bytes4 _method, bytes8 _key) public returns (bool) {
        return gatekeeper.call(_method, _key);
    }

    function callContract(bytes4 _method) public returns (bool) {
        return gatekeeper.call(_method);
    }

    function callDelegate(bytes4 _method) public returns (bool) {
        return gatekeeper.delegatecall(_method);
    }

    function setData(uint _input) public {
        data = _input;
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

    function giveOriginBytes8() public view returns (bytes8) {
        return bytes8(tx.origin);
    }

    function giveBytes8of16(uint16 _input) public view returns (bytes8) {
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
