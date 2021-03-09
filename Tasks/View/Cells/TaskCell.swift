//
//  TaskCell.swift
//  Tasks
//
//  Created by Grigory Stolyarov on 08.03.2021.
//

import UIKit

protocol AddSubtaskDelegate: AnyObject {
    func addSubtaskAction(button: UIButton)
}

class TaskCell: UITableViewCell {
    
    weak var addSubtaskDelegate: AddSubtaskDelegate!
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBAction func addSubtaskButtonTapped(_ sender: UIButton) {
        addSubtaskDelegate.addSubtaskAction(button: sender)
    }
    
}
