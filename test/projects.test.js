const Projects = artifacts.require("Projects");

contract("Projects" , accouts => {

   it("add new project" , async ()=> {
        const instance = await Projects.deployed();
        await instance.addNewProject("Test1");
        assert.equal(instance.getProjectsCount() , 1);
   });

});