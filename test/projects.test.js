const ProjectsFactory = artifacts.require('ProjectsFactory')
const Project = artifacts.require('Projects')

contract('Projects', (accounts) => {
  let contractInstance = null
  const TaskStatus = {
    TODO: 0,
    DOING: 1,
    REVIEW: 2,
    DONE: 3,
  }
  before(async () => {
    const fact = await ProjectsFactory.new()
    assert(fact.address)
    await fact.createProject()
    contractInstance = await Project.at((await fact.getDeployedProjects())[0])
  })

  it('add new project', async () => {
    let projectsCount = parseInt(await contractInstance.getProjectsCount())
    await contractInstance.addNewProject('Test1')
    assert.equal(
      ++projectsCount,
      parseInt(await contractInstance.getProjectsCount()),
    )
  })

  it('add new task on the project', async () => {
    await contractInstance.addNewTask(1, 'task title', 'task description', 200)
    assert.equal((await contractInstance.getTaskById(1, 1)).title, 'task title')
  })

  it('updte a task on the project', async () => {
    await contractInstance.updateTask(1, 1, 'updated title', 'descriptoin', 200)
    assert.equal(
      (await contractInstance.getTaskById(1, 1)).title,
      'updated title',
    )
  })

  it('assign a task to a memeber', async () => {
    await contractInstance.assignTask(1, 1, accounts[1])
    assert.equal(
      (await contractInstance.getTaskById(1, 1)).assignee,
      accounts[1],
    )
  })

  it('change a task status', async () => {
    await contractInstance.changeTaskStatus(1, 1, TaskStatus.DOING)
    assert.equal(
      (await contractInstance.getTaskById(1, 1)).status,
      TaskStatus.DOING,
    )
  })

  it('done a task status', async () => {
    await contractInstance.changeTaskStatus(1, 1, TaskStatus.DONE)
    assert.equal(
      (await contractInstance.getTaskById(1, 1)).status,
      TaskStatus.DONE,
    )
  })

  it('delete a task from the project', async () => {
    await contractInstance.deleteTaskById(1, 1)
    assert.equal((await contractInstance.getTaskById(1, 1)).title, '')
  })

  it('delete a project', async () => {
    let projectsCount = await contractInstance.getProjectsCount()
    await contractInstance.deleteProject(
      await contractInstance.getProjectIdByIndex(projectsCount - 1),
    )
    assert.equal(
      --projectsCount,
      parseInt(await contractInstance.getProjectsCount()),
    )
  })
})
