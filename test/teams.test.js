const Teams = artifacts.require("Teams");

contract ('Teams', accounts =>{

    let contractInstance = null;
    before(async ()=>{
        contractInstance = await Teams.deployed();
    });


});
