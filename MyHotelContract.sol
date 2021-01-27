pragma solidity ^0.6.0;

contract HotelRoom {
    
    enum Statuses { Vacant, Occupied }
    Statuses currentStatus;
    
    event Occupy(address _occupant, uint _value);
    
    address payable public owner;
    
    constructor() public{
        //whoever deploys contract is owner
        owner = msg.sender;
        currentStatus = Statuses.Vacant;
    }
    
    modifier onlyWhileVacant {
        require(currentStatus == Statuses.Vacant, "Transaction failedCurrently occupied");
        _;
    }
    
    modifier costs (uint _amount) {
        require(msg.value  >= _amount, "Not enough ether provided");
        _;
    }
    
    //when ethereum is recieved the the address this function will execute 
    receive() external payable onlyWhileVacant costs(2 ether){
        
        currentStatus = Statuses.Occupied;
        //pay owner to book hotel room
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }
}
