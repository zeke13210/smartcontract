var TodoList = artifacts.require("./TodoList.sol");


//used to migrate contract to blockchain
module.exports = function(deployer) {
  deployer.deploy(TodoList);
};