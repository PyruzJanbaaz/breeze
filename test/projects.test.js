const Projects = artifacts.require("Projects");

contract ('Projects', accounts =>{

    let contractInstance = null;
    const TaskStatus = {
        TODO: 0,
        DOING: 1,
        REVIEW: 2,
        DONE: 3
    };
    before(async ()=>{
        contractInstance = await Projects.deployed();
    });

    it('add new project', async ()=> {
        let projectsCount = parseInt(await contractInstance.getProjectsCount());
        await contractInstance.addNewProject('Test1');
		assert.equal(++projectsCount , parseInt(await contractInstance.getProjectsCount()));
    });

    it('add new task on the project', async ()=> {
        await contractInstance.addNewTask(1 , 'task title' , 'task description');
        assert.equal((await contractInstance.getTaskById(1,1)).title, 'task title');
    });

    it('updte a task on the project', async ()=> {
        await contractInstance.updateTask(1,1,'updated title', 'descriptoin');
        assert.equal((await contractInstance.getTaskById(1,1)).title, 'updated title');
    });

    it('change a task status', async ()=> {
        await contractInstance.changeTaskStatus(1,1,TaskStatus.DOING);
        assert.equal((await contractInstance.getTaskById(1,1)).status, TaskStatus.DOING);
    });

    it('delete a task from the project', async ()=> {
        await contractInstance.deleteTaskById(1,1);
        assert.equal((await contractInstance.getTaskById(1,1)).title, '');
    });

    it('delete a project', async ()=> {
        let projectsCount = await contractInstance.getProjectsCount();
        await contractInstance.deleteProject(await contractInstance.getProjectIdByIndex(projectsCount -1));
        assert.equal(--projectsCount, parseInt(await contractInstance.getProjectsCount()));
    });

});
