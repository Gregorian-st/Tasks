//
//  MainViewController.swift
//  Tasks
//
//  Created by Grigory Stolyarov on 08.03.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    private var tasksMain: [TaskContainer] = []
    private var tasksToShow: [TaskContainer] = []
    private var parentTask: TaskContainer? = nil
    private var curLevel: Int = 0 {
        didSet {
            updateScreen()
        }
    }
    
    @IBOutlet weak var parentTaskLabel: UILabel!
    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var returnButton: UIButton!

    @IBAction func addTaskButtonTapped(_ sender: UIButton) {
        addTask()
    }
    
    @IBAction func returnButtonTapped(_ sender: UIButton) {
        showPreviousTask()
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateScreen()
    }

    // MARK: Program Logic
    
    func updateScreen() {
        returnButton.isHidden = curLevel <= 0
        guard let parentTask = parentTask
        else {
            parentTaskLabel.text = "\\"
            return
        }
        parentTaskLabel.text = parentTask.path
    }
    
    func addTask() {
        let newTask = TaskContainer(name: "Task-\(tasksToShow.count + 1)", parentTask: parentTask)
        tasksToShow.append(newTask)
        if let parentTask = parentTask {
            parentTask.tasks.append(newTask)
        } else {
            tasksMain.append(newTask)
        }
        tasksTableView.reloadData()
    }
    
    func addSubtask(index: Int) {
        var selectedTask: TaskContainer
        selectedTask = curLevel == 0 ? tasksMain[index] : tasksToShow[index]
        
        let newTask = TaskContainer(name: "Task-\(selectedTask.tasks.count + 1)", parentTask: selectedTask)
        selectedTask.tasks.append(newTask)
        
        tasksTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }
    
    func showPreviousTask() {
        if curLevel < 1 {
            return
        }
        if curLevel == 1 {
            parentTask = nil
            tasksToShow = tasksMain
        } else {
            parentTask = parentTask?.parentTask
            tasksToShow = parentTask?.tasks as! [TaskContainer]
        }
        curLevel -= 1
        tasksTableView.reloadData()
    }
    
    func showNextTasks(index: Int) {
        if curLevel > 0 {
            parentTask = parentTask?.tasks[index] as? TaskContainer
        } else {
            parentTask = tasksMain[index]
        }
        curLevel += 1
        tasksToShow = parentTask?.tasks as! [TaskContainer]
        tasksTableView.reloadData()
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasksToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tasksTableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        cell.addSubtaskDelegate = self
        cell.taskNameLabel.text = tasksToShow[indexPath.row].name
        cell.countLabel.text = "Tasks count: \(tasksToShow[indexPath.row].taskCount)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showNextTasks(index: indexPath.row)
    }
    
}

extension MainViewController: AddSubtaskDelegate {
    
    func addSubtaskAction(button: UIButton) {
        guard let indexPath = tasksTableView.indexPath(for: button.forFirstBaselineLayout)
        else { return }
        addSubtask(index: indexPath.row)
    }
    
}
