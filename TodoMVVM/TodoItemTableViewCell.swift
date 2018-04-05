//
//  TodoItemTableViewCell.swift
//  TodoMVVM
//
//  Created by Alexander Blokhin on 05.04.2018.
//  Copyright © 2018 Develop. All rights reserved.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(with viewModel: TodoItemPresentable) {
        textLabel?.text = viewModel.text
        detailTextLabel?.text = viewModel.date
    }
}
