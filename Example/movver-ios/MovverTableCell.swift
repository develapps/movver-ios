//
//  MovverTableCell.swift
//  movver-ios
//
//  Created by Pablo Romeu on 15/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Movver

class MovverTableCell: MOVVER_TableViewCell {
    @IBOutlet weak var theLabel: UILabel!
    override func mv_bind(viewModel: MOVVER_VM_Datasource_Protocol) {
        print("Binding \(viewModel)")
        self.theLabel.text = viewModel.mv_generic_model as? String
    }
    
}
