//
//  TaskTableTableViewController.swift
//  Lista de tarefas
//
//  Created by Gilberto da Luz on 05/02/21.
//

import UIKit

class TaskTableViewController: UITableViewController {
    private var tasks: [Task] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTasks()
    }
    
    private func loadTasks() {
        self.tasks = TaskRepository.shared.getAll()
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            if identifier == "newTask"{
                _ = segue.destination as! TaskDetailViewController
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { self.tasks.count}
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "taskItemCell"
        let currentTask = tasks[indexPath.row]
        let taskDefaultCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        taskDefaultCell.textLabel?.text = currentTask.description
        
        return taskDefaultCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let currentItem = tasks[indexPath.row]
        if editingStyle == .delete {
            deleteCell(currentItem)
        }
    }
    
    private func deleteCell(_ currentItem: Task) {
        let message = "Deseja deletar a tarefa: \(currentItem.description)?"
        let positiveHandler:((UIAlertAction) -> Void)? = { (action) in
            let isSuccess = TaskRepository.shared.delete(task: currentItem)
            if isSuccess {
                AlertHelper.shared.showMessage(viewController: self, message: "Tarefa deletada com sucesso!")
                self.loadTasks()
            }else {
                AlertHelper.shared.showMessage(viewController: self, message: "Error ao deletar tarefa!")
            }
        }
        AlertHelper.shared.showConfirmationMessage(viewController: self, message: message, positiveHandler: positiveHandler)
    }
}
