const Users = artifacts.require("Users");

contract('Users',  accounts => {

	let contractInstance = null;
	before(async ()=>{
		contractInstance = await Users.deployed();
	});

	it('register user', async ()=> {
		let userCount  = parseInt(await contractInstance.getUserCount());
		await contractInstance.register('Pyruz', 'Janbaz','avatar.png');
		assert.equal(++userCount , parseInt(await contractInstance.getUserCount()));
	});

	it('active user status', async ()=> {
		await contractInstance.activeUserStatus(accounts[0]);
		const userStatus = (await contractInstance.getUser(accounts[0])).status;		
		assert.equal(userStatus , '0');
	});

	it('delete user', async ()=>{
		let userCount  = parseInt(await contractInstance.getUserCount());
		await contractInstance.deleteUser(accounts[0]);
		assert.equal(--userCount, parseInt(await contractInstance.getUserCount()));
	});

});

