//
//  TableViewController.swift
//  movver-ios
//
//  Created by Pablo Romeu on 15/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import movver_ios

class TableViewController: MOVVER_VC {

    @IBOutlet weak var tableView: UITableView!
    var tableViewDataSource : MOVVER_TableViewDataSource<MovverTableCell>?
    var unwrappedViewModel:TableViewModel{
        get{
            return self.delegateViewModel as! TableViewModel
        }
    }

    override func viewDidLoad() {
        self.setupTableView()
        
    }
    
    func setupTableView() {
        self.tableView.estimatedRowHeight = 40
        self.tableViewDataSource = MOVVER_TableViewDataSource<MovverTableCell>(viewModelDataSource: unwrappedViewModel.viewModelDatasource)
        self.tableView.dataSource = self.tableViewDataSource
        self.tableView.reloadData()
    }

    
    


}

