//
//  CollectionViewController.swift
//  movver-ios
//
//  Created by Pablo Romeu on 20/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import movver_ios

class CollectionViewController: MOVVER_VC {
    
    @IBOutlet weak var tableView: UITableView!
    var collectionViewDataSource : MOVVER_CollectionViewDataSource<MovverCollectionCell,_>?
    var unwrappedViewModel:TableViewModel{
        get{
            return self.delegateViewModel as! TableViewModel
        }
    }
    
    override func viewDidLoad() {
        self.setupTableView()
        
    }
    
    func setupTableView() {
        self.tableView.rowHeight = 60
        self.tableViewDataSource = MOVVER_TableViewDataSource<MovverTableCell>(viewModelDataSource: unwrappedViewModel.viewModelDatasource)
        self.tableView.dataSource = self.tableViewDataSource
        self.tableView.reloadData()
    }
    
    
    
    
    
}

