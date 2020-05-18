pragma solidity ^0.4.17;

contract Station {

    address public stationOwner;
    uint public price = .01 ether;
  
    function Station() public {
        stationOwner = msg.sender;
    }
    
    modifier restricted() {
        require(msg.sender == stationOwner);
        _;
    }
    function setPrice(uint _price) public restricted {
       price = _price;
    }
    
   function startCharging() public payable {
       require(msg.value > price);
       transferBalance();
       
   }
   
   function transferBalance() public {
       stationOwner.transfer(this.balance);
   }
}
