//
//  CollectionViewController.swift
//  movver-ios
//
//  Created by Pablo Romeu on 20/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Movver



class CollectionViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var collectionViewDataSource : MOVVER_CollectionViewDataSource<MOVVER_CollectionViewCell,MOVVER_ReusableView>?
    var unwrappedViewModel:CollectionViewModel{
        get{
            return self.mv_generic_viewModel as! CollectionViewModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        
    }
    
    func setupTableView() {
        self.collectionViewDataSource = MOVVER_CollectionViewDataSource<MOVVER_CollectionViewCell,MOVVER_ReusableView>(viewModelDataSource: unwrappedViewModel.viewModelDatasource)
        self.collectionView.dataSource = self.collectionViewDataSource
        self.collectionView.reloadData()
    }
    
    
    
    
    
}

