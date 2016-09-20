//
//  CollectionViewController.swift
//  movver-ios
//
//  Created by Pablo Romeu on 20/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import movver_ios



class CollectionViewController: MOVVER_VC {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var collectionViewDataSource : MOVVER_CollectionViewDataSource<MovverCollectionCell,MOVVER_ReusableView>?
    var unwrappedViewModel:CollectionViewModel{
        get{
            return self.delegateViewModel as! CollectionViewModel
        }
    }
    
    override func viewDidLoad() {
        self.setupTableView()
        
    }
    
    func setupTableView() {
        self.collectionViewDataSource = MOVVER_CollectionViewDataSource<MovverCollectionCell,MOVVER_ReusableView>(viewModelDataSource: unwrappedViewModel.viewModelDatasource)
        self.collectionView.dataSource = self.collectionViewDataSource
        self.collectionView.reloadData()
    }
    
    
    
    
    
}

