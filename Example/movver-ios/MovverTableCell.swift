//
//  MovverTableCell.swift
//  movver-ios
//
//  Created by Pablo Romeu on 15/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import movver_ios

class MovverTableCell: MOVVER_TableViewCell {
    @IBOutlet weak var theLabel: UILabel!
    override func movver_bind(viewModel: MOVVER_VM_Datasource_Protocol) {
        print("Binding \(viewModel)")
        self.theLabel.text = viewModel.movver_model as? String
    }
    
}
