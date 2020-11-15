//
//  TableView.swift
//  Daily.v2
//
//  Created by Бакулин Семен Александрович on 09.11.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    //MARK: - Variables
    public weak var delegateObject: ViewControllerWithTable!
    private let animationManager = AnimationManager.CellAnimationManager()
    
    //MARK: - Inits
    override init(style: UITableView.Style) {
        super.init(style: style)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = AppConfig.shared.mainBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Touches Began
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tableView.endEditing(true)
    }
    
    //MARK: - Utils
    
    private func getAllTasks()->[Task]{
        return delegateObject.viewModel.tasks
    }

    //MARK: - DataSource and Delegate

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getAllTasks().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        let parentViewModel = delegateObject.viewModel
        
        let currentTask = parentViewModel.getCurrentTask(index: indexPath.row)
        
        cell.cellViewModel = CellViewModel(task: currentTask, parent: parentViewModel)
        cell.dequeCellSetup()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableViewCell else { return }
        animationManager.animateCell(cell: cell, withDelay: 0.0)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) as? TableViewCell else { fatalError("error can't load cell")}
        let contextualAction = UIContextualAction(style: .destructive, title: nil) { [unowned self] (act, view, block) in
            self.delegateObject.viewModel.deleteTask(task: cell.cellViewModel.task)
            tableView.reloadData()
            self.delegateObject.setupLabelText(taskCount: self.getAllTasks().count)
        }
        contextualAction.backgroundColor = .gray
        contextualAction.image = UIImage(named: "delete")
        
        let actConfiguration = UISwipeActionsConfiguration(actions: [contextualAction])
        return actConfiguration
    }
}
