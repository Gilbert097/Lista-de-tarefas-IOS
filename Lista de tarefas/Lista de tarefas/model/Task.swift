//
//  Task.swift
//  Lista de tarefas
//
//  Created by Gilberto da Luz on 06/02/21.
//

import Foundation

class Task: Codable{
    var id:String
    var description:String
    
    init(description:String) {
        self.id = UUID().uuidString
        self.description = description
    }
    
}
