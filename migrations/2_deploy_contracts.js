const fs = require('fs');
const path = require('path');

const CONTRACTADDRESS_FILEPATH = path.resolve(__dirname) + '/../OUTPUTS/smart-contract-address.txt'

var OZGToken = artifacts.require("./OZGToken.sol");

module.exports = function(deployer) {
  deployer.deploy(OZGToken).then(function() {   
    
            console.log('OZGToken.address = ' + OZGToken.address)
            fs.writeFile(CONTRACTADDRESS_FILEPATH, OZGToken.address, function(err) {
              if(err) {
                  return console.log(err);
              }
              console.log("The file " + CONTRACTADDRESS_FILEPATH + " was saved!");
          }); 
        });
};
