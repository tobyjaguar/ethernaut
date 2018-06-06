pragma solidity ^0.4.18;

contract GatekeeperTwo {

  address public entrant;
  uint64 public kValue;
  uint64 public xValue;
  uint64 public zValue;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller) }
    require(x == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(keccak256(msg.sender)) ^ uint64(_gateKey) == uint64(0) - 1);
    _;
  }

  function giveGak(bytes8 _gateKey) public {
      kValue = uint64(keccak256(msg.sender));
      xValue = uint64(keccak256(msg.sender)) ^ uint64(_gateKey);
      zValue = uint64(0) - 1;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}
