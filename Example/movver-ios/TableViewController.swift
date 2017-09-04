//
//  TableViewController.swift
//  movver-ios
//
//  Created by Pablo Romeu on 15/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Movver

class TableViewController: BaseViewController {

	
    @IBOutlet weak var tableView: UITableView!
    var tableViewDataSource : MOVVER_TableViewDataSource<MOVVER_TableViewCell>?
    var unwrappedViewModel:TableViewModel{
        get{
            return self.mv_generic_viewModel as! TableViewModel
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        
    }
    
    func setupTableView() {
        self.tableView.rowHeight = 60
        self.tableViewDataSource = MOVVER_TableViewDataSource<MOVVER_TableViewCell>(viewModelDataSource: unwrappedViewModel.viewModelDatasource)
        self.tableView.dataSource = self.tableViewDataSource
        self.tableView.reloadData()
    }

}

