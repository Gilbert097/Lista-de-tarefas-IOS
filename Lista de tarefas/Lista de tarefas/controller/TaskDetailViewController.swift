//
//  ViewController.swift
//  Lista de tarefas
//
//  Created by Gilberto da Luz on 05/02/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTaskButtonClick(_ sender: UIButton) {
        let newTask = Task(description: taskTextField.text ?? "")
        let isSucess = TaskRepository.shared.save(task: newTask)
        if isSucess {
            AlertHelper.shared.showMessage(viewController: self ,message: "Tarefa criada com sucesso!"){ _ in
                self.taskTextField.text = ""
            }
        }else{
            AlertHelper.shared.showMessage(viewController: self,message: "Error ao criar tarefa.",handler: nil)
        }
    }
    
    
}

