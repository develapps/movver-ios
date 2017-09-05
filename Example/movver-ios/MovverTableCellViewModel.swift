//
//  MovverTableViewModel.swift
//  movver-ios
//
//  Created by Pablo Romeu on 15/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Movver

class MovverTableViewModel: MOVVER_TableCellViewModel {
    override func mv_identifier() -> String {
		return String(describing:MovverTableCell.self)
    }
}
