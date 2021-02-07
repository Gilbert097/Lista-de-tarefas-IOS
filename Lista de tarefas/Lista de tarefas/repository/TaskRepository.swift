//
//  TaskRepository.swift
//  Lista de tarefas
//
//  Created by Gilberto da Luz on 06/02/21.
//

import Foundation

struct TaskRepository {
    static let shared = TaskRepository()
    private init() { }
    
    func getAll() -> [Task]{
        do {
            if let taskRecovered = UserDefaults.standard.value(forKey: TaskParameter.tasks.rawValue) as? Data {
                let decoder = JSONDecoder()
                let tasksDecoded = try decoder.decode(Array.self, from: taskRecovered) as [Task]
                return tasksDecoded
            }
        } catch let error {
            print(error.localizedDescription)
            return [Task]()
        }
        return [Task]()
    }
    
    func save(task: Task) -> Bool {
        do {
            var tasks = getAll()
            tasks.append(task)
            try persistTasks(tasks)
        } catch let error {
            print(error.localizedDescription)
            return false
        }
        
        return true
    }
    
    func delete(task: Task)->Bool{
        var tasks = getAll()
        let taskElement  = tasks.enumerated().filter { (item) -> Bool in
            item.element.id == task.id
        }.first
        
        if let taskRemove = taskElement {
            do {
                tasks.remove(at: taskRemove.offset)
                try persistTasks(tasks)
            } catch let error {
                print(error.localizedDescription)
                return false
            }
        }else{
            return false
        }
        return true
    }
    
    private func persistTasks(_ tasks: [Task]) throws {
        let encoder = JSONEncoder()
        let tasksEncoded = try encoder.encode(tasks)
        UserDefaults.standard.set(tasksEncoded, forKey: TaskParameter.tasks.rawValue)
    }
}
