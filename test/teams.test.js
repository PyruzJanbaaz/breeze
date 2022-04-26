const Teams = artifacts.require("Teams");

contract ('Teams', accounts =>{

    let contractInstance = null;
    before(async ()=>{
        contractInstance = await Teams.deployed();
    });

    it('add new team', async ()=>{
        let teamsCount = parseInt(await contractInstance.getTeamsCount(1));
        await contractInstance.addNewTeam(1, 'Team1');
        assert.equal(++teamsCount , parseInt(await contractInstance.getTeamsCount(1)));
    });

    it('update a team title', async ()=> {
        await contractInstance.updateTeamTitle(1,'Team.1.2');
        const teamTitle = (await contractInstance.getTeamById(1)).title;
        assert.equal(teamTitle , 'Team.1.2');
    });

    it('assigen a user to a team', async ()=> {
        let teamMembersCount = parseInt(await contractInstance.getTeamMembersCount(1));
        await contractInstance.assignUserToTeam(1, accounts[0]);
        assert.equal(++teamMembersCount , parseInt(await contractInstance.getTeamMembersCount(1)));
    });

    it('unassign a user from a team', async ()=> {
        let teamMembersCount = parseInt(await contractInstance.getTeamMembersCount(1));
        await contractInstance.unassignUserFromTeam(1, accounts[0]);
        assert.equal(--teamMembersCount , parseInt(await contractInstance.getTeamMembersCount(1)));
    });

    it('delete a team', async ()=>{
        let teamsCount = parseInt(await contractInstance.getTeamsCount(1));
        await contractInstance.deleteTeam(1,1);
        assert.equal(--teamsCount, parseInt(await contractInstance.getTeamsCount(1)));
    });

});
