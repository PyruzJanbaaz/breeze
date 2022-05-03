const Projects = artifacts.require("Projects");

contract ('Projects', accounts =>{

    let contractInstance = null;
    before(async ()=>{
        contractInstance = await Projects.deployed();
    });

    it('add new project', async()=>{
        let projectsCount = parseInt(await contractInstance.getProjectsCount());
        await contractInstance.addNewProject('Test1');
		assert.equal(++projectsCount , parseInt(await contractInstance.getProjectsCount()));
    });

    it('delete a project', async ()=>{
        let projectsCount = await contractInstance.getProjectsCount();
        await contractInstance.deleteProject(await contractInstance.getProjectIdByIndex(projectsCount -1));
        assert.equal(--projectsCount, parseInt(await contractInstance.getProjectsCount()));
    });

});
