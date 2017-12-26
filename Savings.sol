pragma solidity ^0.4.0;

contract Savings {
    // set the variable of owner
    address owner;
    
    //setup 2 event listeners UpdateStatus and UserStatus
    event UpdateStatus(string _msg);
    event UserStatus(string _msg, address user, uint amount);
    
    
    //Create Constructor function setting the msg.sender = owner
    function Savings() payable {
        owner = msg.sender;
    }
    
    //setup depositFunds() fuction
    function depositFunds() payable {
       UserStatus("User has deposited some money", msg.sender, msg.value); 
    }
    
    function () payable {
        UserStatus("User has deposited some money", msg.sender, msg.value);
    }
    
    //kill function only owner 
    function kill() onlyOwner {
        suicide(owner);
    }
    
    //withdraw funds function
    function withdrawFunds(uint amount) onlyOwner {
        if (owner.send(amount)) {
            UpdateStatus("User withdraw some money");
        }
    }
    
    //getFunds
   function getFunds() onlyOwner constant returns(uint) {
       return this.balance;
   } 
    
    //modifier 
    modifier onlyOwner() {
        if(owner != msg.sender) {
            throw;
        } else {
            _;
        }
    }
}