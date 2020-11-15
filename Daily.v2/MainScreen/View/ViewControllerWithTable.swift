//
//  ViewController.swift
//  Daily.v2
//
//  Created by Бакулин Семен Александрович on 07.11.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

class ViewControllerWithTable: UIViewController {
    
    //MARK: - Variables
    
    public let viewModel = TableViewViewModel()
    private let tableController = TableViewController(style: .plain)
    
    //MARK: - Views
    
    @IBOutlet private var addTaskButton: UIButton!
    
    private lazy var tableView: UITableView = {
        guard let table = self.tableController.tableView else { fatalError("Could not load core views") }
        tableController.delegateObject = self
        table.translatesAutoresizingMaskIntoConstraints = false
        let emptyView = UIView()
        table.tableFooterView = UIView()
        emptyView.backgroundColor = AppConfig.shared.mainBackgroundColor
        tableController.tableView.backgroundView = emptyView
        self.view.addSubview(table)
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 4),
            table.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        return table
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = UIFont(name: AppConfig.shared.fontLiteral, size: 16)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16)
        ])
        return label
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        screenSetup()
        setupSubviewsFacade()
        moveTableControllerToEnableKeyboardBehavior()
    }
    
    //MARK - Touches began
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Setup screen
    
    private func screenSetup(){
        title = AppConfig.shared.navigationBarTitle
        view.backgroundColor = AppConfig.shared.mainBackgroundColor
        setupNavBarButton()
    }
    
    public func setupNavBarButton(){
        let imageDelete = UIImage(named: "delete")
        let rightButton = UIBarButtonItem(image: imageDelete, style: .bordered, target: self, action: #selector(deleteAllTasks(sender:)))
        rightButton.setValue(UIColor.white, forKey: "tintColor")
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func deleteAllTasks(sender: UIBarButtonItem){
        viewModel.deleteAllTasks()
        tableView.reloadData()
    }
    
    //MARK: - Setup subviews
    
    private func setupSubviewsFacade(){
        setupLabelText(taskCount: viewModel.tasks.count)
        setupTableView()
        AddButtonSetup()
    }
    
    private func setupTableView(){
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
    }
    
    private func AddButtonSetup(){
        addTaskButton.layer.cornerRadius = 15
        addTaskButton.layer.shadowColor = #colorLiteral(red: 0.09352494031, green: 0.09297668189, blue: 0.09395133704, alpha: 1).cgColor
        addTaskButton.layer.shadowOpacity = 1
        addTaskButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        addTaskButton.layer.shadowRadius = 6.0
        addTaskButton.addTarget(self, action: #selector(addTask(sender: )), for: .touchUpInside)
        view.bringSubviewToFront(addTaskButton)
    }
    
    //MARK: - Utility
    
    public func setupLabelText(taskCount: Int){
        label.text = "Today you have \(taskCount) tasks"
    }
    
    private func moveTableControllerToEnableKeyboardBehavior(){
        addChild(tableController)
        tableController.didMove(toParent: self)
    }
}

extension ViewControllerWithTable{
    @objc func addTask(sender: UIButton){
        viewModel.createTask()
        setupLabelText(taskCount: viewModel.tasks.count)
        tableView.reloadData()
    }
}

