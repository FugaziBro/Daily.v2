//
//  TableViewCell.swift
//  Daily.v2
//
//  Created by Бакулин Семен Александрович on 09.11.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    //MARK: - Varibables
    private var isExpand = false {
        didSet{
            oldValue == false ? dateAnimation(height: 150) : dateAnimation(height: 0)
        }
    }
    
    public var isAnimated = false
    
    public var cellViewModel: CellViewModel!
    
    //MARK: - Views
    public let textView = UITextView(frame: .zero)
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        picker.setValue(UIColor.white, forKey: "textColor")
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(picker)
        NSLayoutConstraint.activate([
            picker.topAnchor.constraint(equalTo: self.dateButton.bottomAnchor,constant: 8),
            picker.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            picker.heightAnchor.constraint(equalToConstant: 0),
            picker.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        picker.addTarget(self, action: #selector(datePickerChangedValue(sender:)), for: .valueChanged)
        return picker
    }()
    
    public lazy var dateButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitleColor(#colorLiteral(red: 0.6010558009, green: 0.5974856615, blue: 0.6038019061, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "cell")
        contentView.backgroundColor = AppConfig.shared.mainBackgroundColor
        setupButton()
        textViewSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Views Setup
    
    private func textViewSetup(){
        textView.isScrollEnabled = false
        textView.delegate = self
        textView.backgroundColor = #colorLiteral(red: 0.1690546274, green: 0.171423018, blue: 0.1773887277, alpha: 1)
        textView.textColor = .white
        textView.font = UIFont(name: "Helvetica", size: 14)
        textView.layer.cornerRadius = 10
        textView.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        textView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textView.bottomAnchor.constraint(equalTo: dateButton.topAnchor, constant: -4),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 8),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
    
    private func setupButton(){
        contentView.addSubview(dateButton)
        NSLayoutConstraint.activate([
            dateButton.bottomAnchor.constraint(equalTo: datePicker.topAnchor, constant: -8),
            dateButton.heightAnchor.constraint(equalToConstant: 38),
            dateButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
        ])
        dateButton.addTarget(self, action: #selector(toggle(sender:)), for: .touchUpInside)
    }
    
    // Setup Cell Data from an 
    public func dequeCellSetup(){
        reloadDataOfViews()
        self.textView.text = cellViewModel.task.text
        
    }
}

extension TableViewCell: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        let superView = self.superview as? UITableView
        let newText = textView.text
        superView?.beginUpdates()
        cellViewModel.changeTaskText(newTaskText: newText)
        superView?.endUpdates()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "type something"{
            textView.text = ""
            textView.textColor = .white
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

//MARK: - Button Functional

extension TableViewCell{
    
    // Works on buttonClick
    
    @objc func toggle(sender: UIButton){
        self.isExpand.toggle()
    }
    
    // Date picker changed value
    
    @objc func datePickerChangedValue(sender: UIDatePicker){
        cellViewModel.changeTaskDate(newDate: sender.date)
        reloadDataOfViews()
    }
    
    // Reload view data on date change
    
    private func reloadDataOfViews(){
        dateButton.setTitle(DateConverter.getDateAsString(date: self.cellViewModel.task.date!), for: .normal)
        datePicker.date = self.cellViewModel.task.date!
    }
    
    // Changes datePickerHeight
    private func dateAnimation(height: CGFloat){
        guard let superView = superview as? UITableView else { return }
        superView.beginUpdates()
        NSLayoutConstraint.deactivate(datePicker.constraints)
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: self.dateButton.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: height),
            datePicker.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        superView.endUpdates()
    }
}
