//
//  MOVVERCollectionViewDatasource.swift
//  Santoral Pro
//
//  Created by Pablo Romeu on 8/7/16.
//  Copyright © 2016 Pablo Romeu. All rights reserved.
//

import Foundation

// MARK:
// MARK: Collection Datasource

public protocol MOVVER_ReusableViewModel_Datasource_Protocol:MOVVER_VM_Datasource_Protocol {
    
}


public protocol MOVVER_ReusableView_Datasource_Protocol:MOVVER_Cell_Datasource_Protocol {
    
}


public protocol MOVVER_CollectionCell_Datasource {
    var viewModelDataSource:MOVVER_CollectionVM_Datasource? { get set }
}

public protocol MOVVER_CollectionVM_Datasource {
    func movver_collectionDatasource(numberOfItemsInSection section: Int) -> Int
    func movver_collectionDatasource(viewModelForItemAt indexPath: IndexPath) -> MOVVER_VM_Datasource_Protocol
    func movver_collectionDatasource_numberOfSections() -> Int
    
    func movver_collectionDatasource(canMoveItemAt indexPath: IndexPath) -> Bool
    func movver_collectionDatasource(moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
}

public protocol MOVVER_CollectionVM_DatasourceSupplementaryViews {
    func movver_collectionDatasource(viewModelForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> MOVVER_VM_Datasource_Protocol?
}

public protocol MOVVER_CollectionVM_DatasourcePrefetching {
    func movver_collectionDatasource(prefetchItemsAt: [IndexPath])
    func movver_collectionDatasource(cancelPrefetchingForItemsAt: [IndexPath])
}

public protocol MOVVER_CollectionViewDataSourceDelegate {
    func movver_delegate(datasource: MOVVER_CollectionCell_Datasource, preBindCell: MOVVER_Cell_Datasource_Protocol, atIndexPath:IndexPath)
    func movver_delegate(datasource: MOVVER_CollectionCell_Datasource, postBindCell: MOVVER_Cell_Datasource_Protocol, atIndexPath:IndexPath)
    func movver_delegate(datasource: MOVVER_CollectionCell_Datasource, preBindSuplemementaryView: MOVVER_ReusableView_Datasource_Protocol, atIndexPath:IndexPath)
    func movver_delegate(datasource: MOVVER_CollectionCell_Datasource, postBindSuplementaryView: MOVVER_ReusableView_Datasource_Protocol, atIndexPath:IndexPath)
    
}


open class MOVVER_CollectionViewDataSource<C,RV>:NSObject,UICollectionViewDataSource,MOVVER_CollectionCell_Datasource,UICollectionViewDataSourcePrefetching
                                    where   C:UICollectionViewCell      , C: MOVVER_Cell_Datasource_Protocol,
                                            RV:UICollectionReusableView , RV: MOVVER_ReusableView_Datasource_Protocol{
    
    public var noDataView:UIView?
    private var oldView:UIView?
    public var viewModelDataSource:MOVVER_CollectionVM_Datasource?
    public var datasourceDelegate:MOVVER_CollectionViewDataSourceDelegate?
    
    public init(viewModelDataSource: MOVVER_CollectionVM_Datasource) {
        self.viewModelDataSource = viewModelDataSource
    }
    
    public convenience init(viewModelDataSource: MOVVER_CollectionVM_Datasource, datasourceDelegate:MOVVER_CollectionViewDataSourceDelegate) {
        self.init(viewModelDataSource:viewModelDataSource)
        self.datasourceDelegate = datasourceDelegate
    }
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        let sectionCount = self.viewModelDataSource?.movver_collectionDatasource_numberOfSections()
        if (sectionCount==0) {
            if  (self.noDataView != nil ) &&
                (collectionView.backgroundView != self.noDataView)
            {
                self.oldView = collectionView.backgroundView;
                collectionView.backgroundView = self.noDataView;
            }
        }
        else if (collectionView.backgroundView == self.noDataView){
            collectionView.backgroundView = self.oldView;
        }
        return sectionCount ?? 0;
        
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return viewModelDataSource?.movver_collectionDatasource(numberOfItemsInSection: section) ?? 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let viewModel = self.viewModelDataSource?.movver_collectionDatasource(viewModelForItemAt: indexPath) {
            
            let identifier = viewModel.movver_identifier()
            let cell:C = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! C
            
            self.datasourceDelegate?.movver_delegate(datasource: self, preBindCell: cell, atIndexPath: indexPath)
            cell.movver_bind(viewModel: viewModel)
            self.datasourceDelegate?.movver_delegate(datasource: self, postBindCell: cell, atIndexPath: indexPath)
            return cell
        }
        return UICollectionViewCell()
    }
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let viewModelDataSourceSV = self.viewModelDataSource as? MOVVER_CollectionVM_DatasourceSupplementaryViews else {
            return UICollectionReusableView()
        }
        if let viewModel:MOVVER_ReusableViewModel_Datasource_Protocol = viewModelDataSourceSV.movver_collectionDatasource(viewModelForSupplementaryElementOfKind: kind, at: indexPath) as? MOVVER_ReusableViewModel_Datasource_Protocol{
            let identifier:String = viewModel.movver_identifier()
            let view:RV = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as! RV
            self.datasourceDelegate?.movver_delegate(datasource: self, preBindSuplemementaryView: view, atIndexPath: indexPath)
            view.movver_bind(viewModel: viewModel)
            self.datasourceDelegate?.movver_delegate(datasource: self, postBindSuplementaryView: view, atIndexPath: indexPath)
            return view;
            
        }
        return UICollectionReusableView()
    }
    
    open func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]){
        guard let prefetchigDatasource = self as? MOVVER_CollectionVM_DatasourcePrefetching else { return }
        prefetchigDatasource.movver_collectionDatasource(prefetchItemsAt: indexPaths)
    }
    
    open func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]){
        guard let prefetchigDatasource = self as? MOVVER_CollectionVM_DatasourcePrefetching else { return }
        prefetchigDatasource.movver_collectionDatasource(cancelPrefetchingForItemsAt: indexPaths)
    }
    
    
}

// MARK: Array helper

extension Array:MOVVER_CollectionVM_Datasource,MOVVER_CollectionVM_DatasourcePrefetching{
    public func movver_collectionDatasource(numberOfItemsInSection section: Int) -> Int{
        return self.count
    }
    public  func movver_collectionDatasource(viewModelForItemAt indexPath: IndexPath) -> MOVVER_VM_Datasource_Protocol{
        let viewModel:MOVVER_VM_Datasource_Protocol = self[indexPath.row] as! MOVVER_VM_Datasource_Protocol
        return viewModel
    }
    public func movver_collectionDatasource_numberOfSections() -> Int{
        return self.count>0 ? 1 : 0
    }
    
    public func movver_collectionDatasource(canMoveItemAt indexPath: IndexPath) -> Bool { return false }
    public func movver_collectionDatasource(moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) { }
    
    public func movver_collectionDatasource(prefetchItemsAt: [IndexPath]) {
        for indexPath in prefetchItemsAt
        {
            if let viewModel = self[indexPath.row] as? MOVVER_VM_DatasourcePreload_Protocol {
                viewModel.movver_preload()
            }
            
        }
        
    }
    public func movver_collectionDatasource(cancelPrefetchingForItemsAt: [IndexPath]) {
        for indexPath in cancelPrefetchingForItemsAt
        {
            if let viewModel = self[indexPath.row] as? MOVVER_VM_DatasourcePreload_Protocol {
                viewModel.movver_cancelPreloading()
            }
            
        }
        
    }
}

// MARK: Cell Helper

open class MOVVER_CollectionViewCell:UICollectionViewCell,MOVVER_VC_Protocol,MOVVER_Cell_Datasource_Protocol{
    
    open var movver_delegateViewModel:MOVVER_VM_Protocol?
    
    open func movver_bind(viewModel: MOVVER_VM_Datasource_Protocol) {
        assertionFailure("ERROR: Implement this")
    }
    open func movver_VM_Call(event: Any){
        assertionFailure("ERROR: Implement this")
    }
    
}

// MARK: ReusableViewHelper

open class MOVVER_ReusableView: UICollectionReusableView,MOVVER_ReusableView_Datasource_Protocol {
    open var movver_delegateViewModel:MOVVER_VM_Protocol?
    
    open func movver_bind(viewModel: MOVVER_VM_Datasource_Protocol) {
        assertionFailure("ERROR: Implement this")
    }
    open func movver_VM_Call(event: Any){
        assertionFailure("ERROR: Implement this")
    }
}



// MARK: Cell ViewModel Helper

open class MOVVER_CollectionCellViewModel: MOVVER_VM,MOVVER_VM_Datasource_Protocol,MOVVER_VM_DatasourcePreload_Protocol {
    public var movver_delegateViewModel: MOVVER_VM_Protocol?
    
    public required init() {
        super.init()
    }
    public required init(model: Any?, delegateViewModel: MOVVER_VM_Protocol?, router: MOVVER_RT_Protocol?) {
        super.init()
        self.movver_delegateViewModel = delegateViewModel
        self.movver_model = model
        self.movver_delegateRouter = router
    }
    
    open func movver_identifier() -> String {
        assertionFailure("ERROR: Implement this")
        return ""
    }
    open func movver_preload() {
        print("Trying to preload \(self). Do you forget to implement this?")
    }
    open func movver_cancelPreloading() {
        print("Trying to cancel preload \(self). Do you forget to implement this?")
    }
}

// MARK: ReusableViewHelper ViewModel Helper

open class MOVVER_ReusableViewModel: MOVVER_VM,MOVVER_ReusableViewModel_Datasource_Protocol {
    public var movver_delegateViewModel: MOVVER_VM_Protocol?
    public required init() {
        super.init()
    }
    public required init(model: Any?, delegateViewModel: MOVVER_VM_Protocol?, router: MOVVER_RT_Protocol?) {
        super.init()
        self.movver_delegateViewModel = delegateViewModel
        self.movver_model = model
        self.movver_delegateRouter = router
    }
        
    open func movver_identifier() -> String {
        assertionFailure("ERROR: Implement this")
        return ""
    }
    open func movver_preload() {
        print("Trying to preload \(self). Do you forget to implement this?")
    }
    open func movver_cancelPreloading() {
        print("Trying to calcel preload \(self). Do you forget to implement this?")
    }
}



