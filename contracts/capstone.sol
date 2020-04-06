pragma solidity >=0.4.22 <0.6.0;

contract StationFactory {
    address[] public deployedStation;
    uint public stationNo;

    function createStation(string location, string stationType, uint capacity) public {
        address newStation = new Station(location, stationType, capacity, msg.sender);
        stationNo = stationNo + 1;
        deployedStation.push(newStation);
    }

    function getDeployedStation() public view returns (address[]) {
        return deployedStation;
    }
}
contract Station {
    
    struct Slot {
        bool isAvailable;
        address owner;
        uint capacity;
        uint price;
    }

    Slot[24] public slots;

    
    address public stationOwner;
    address public userAddress;
    string public location;
    uint public totalCapacity;
    string public stationType;
    uint public price;

    
    modifier restricted() {
        require(msg.sender == stationOwner);
        _;
    }
   
    constructor (string _location, string _stationType, uint _capacity, address creator) public {
        stationOwner = creator;
        stationType = _stationType;
        location = _location;
        totalCapacity = _capacity;
        
        for (uint i=0; i<23; i++) {
        slots[i] = Slot({capacity: _capacity, isAvailable: true, owner: userAddress, price: price});
        }
    }

    
    function setPrice(uint _price) public restricted {
       price = _price;
    }
    
    function makeReservation(uint _index) public {
        Slot storage slot = slots[_index];
        require(slot.isAvailable);
        slot.capacity--;
        slot.owner = msg.sender;
        if(slot.capacity<1) {
            slot.isAvailable = false;
        }
    }
    
     function getSlots() public view returns(address[], bool[], uint[]) {
        address[] memory addrs = new address[](23);
        bool[] memory isAvailable = new bool[](23);
        uint[] memory capacity = new uint[](23);

        for (uint i = 0; i < 23; i++) {
            Slot storage slot = slots[i];
            addrs[i] = slot.owner;
            capacity[i] = slot.capacity;
            isAvailable[i] = slot.isAvailable;
        }

        return (addrs, isAvailable, capacity);
    }

     function getSlot(uint index) public view returns(address, bool, uint) {
         return (slots[index].owner, slots[index].isAvailable, slots[index].capacity);
    }
}
