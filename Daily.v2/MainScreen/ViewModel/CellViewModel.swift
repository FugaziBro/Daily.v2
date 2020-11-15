//
//  CellViewModel.swift
//  Daily.v2
//
//  Created by Бакулин Семен Александрович on 11.11.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import Foundation

final class CellViewModel {
    public let task: Task
    private unowned let parentViewModel: TableViewViewModel
    
    public func changeTaskText(newTaskText: String?){
        guard let text = newTaskText else { return }
        self.task.text = text
        parentViewModel.saveMainContext()
    }
    
    public func changeTaskDate(newDate: Date?){
        guard let date = newDate else { return }
        self.task.date = date
        parentViewModel.saveMainContext()
    }
    
    init(task: Task, parent: TableViewViewModel){
        self.task = task
        self.parentViewModel = parent
    }
}
