const ProjectsFactory = artifacts.require("ProjectFactory");
const Project = artifacts.require("Project");

contract("Projects", (accounts) => {
  let contractInstance = null;
  const TaskStatus = {
    TODO: 0,
    DOING: 1,
    REVIEW: 2,
    DONE: 3,
  };
  before(async () => {
    const projectsFactory = await ProjectsFactory.new();
    assert(projectsFactory.address);
    await projectsFactory.createProject();
    contractInstance = await Project.at(
      (
        await projectsFactory.getDeployedProjects()
      )[0]
    );
  });

  it("add new project", async () => {
    await contractInstance.addNewProject("Test1", "Description1");
    console.log(await web3.eth.getBalance(contractInstance.address));
    console.log(await web3.eth.getBalance(accounts[1]));
    await contractInstance.log();
    await contractInstance.sendTransaction({
      from: accounts[1],
      value: web3.utils.toWei("1", "ether"),
    });
    await contractInstance.contribute({
      from: accounts[1],
      value: web3.utils.toWei("1", "ether"),
    });
    console.log(await web3.eth.getBalance(contractInstance.address));
    assert.equal((await contractInstance.getProjectInfo()).title, "Test1");
  });

  it("add new task on the project", async () => {
    await contractInstance.addNewTask("task title", "task description", 200);
    assert.equal((await contractInstance.getTaskById(1)).title, "task title");
  });

  it("update a task on the project", async () => {
    await contractInstance.updateTask(1, "updated title", "descriptoin", 200);
    assert.equal(
      (await contractInstance.getTaskById(1)).title,
      "updated title"
    );
  });

  it("assign a task to a memeber", async () => {
    await contractInstance.assignTask(1, accounts[1]);
    assert.equal((await contractInstance.getTaskById(1)).assignee, accounts[1]);
  });

  it("change a task status", async () => {
    await contractInstance.changeTaskStatus(1, TaskStatus.DOING);
    assert.equal(
      (await contractInstance.getTaskById(1)).status,
      TaskStatus.DOING
    );
  });

  it("done a task status", async () => {
    await contractInstance.changeTaskStatus(1, TaskStatus.DONE);
    assert.equal(
      (await contractInstance.getTaskById(1)).status,
      TaskStatus.DONE
    );
  });

  it("delete a task from the project", async () => {
    await contractInstance.deleteTaskById(1);
    assert.equal((await contractInstance.getTaskById(1)).title, "");
  });
});
