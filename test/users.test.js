const Users = artifacts.require("Users");

contract('Users',  accounts => {

	let contractInstance = null;
	const UserStatus = {
		ACTIVE: 0, 
		INACTIVE: 1, 
		LOCKED: 2, 
		PENDING:3 
    };
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
		assert.equal(userStatus , UserStatus.ACTIVE);
	});

	it('delete user', async ()=>{
		let userCount  = parseInt(await contractInstance.getUserCount());
		await contractInstance.deleteUser(accounts[0]);
		assert.equal(--userCount, parseInt(await contractInstance.getUserCount()));
	});

});

