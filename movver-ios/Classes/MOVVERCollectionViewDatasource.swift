//
//  MOVVERCollectionViewDatasource.swift
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
	func mv_collectionDatasource(numberOfItemsInSection section: Int) -> Int
	func mv_collectionDatasource(viewModelForItemAt indexPath: IndexPath) -> MOVVER_VM_Datasource_Protocol
	func mv_collectionDatasource_numberOfSections() -> Int
	
	func mv_collectionDatasource(canMoveItemAt indexPath: IndexPath) -> Bool
	func mv_collectionDatasource(moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
}

public protocol MOVVER_CollectionVM_DatasourceSupplementaryViews {
	func mv_collectionDatasource(viewModelForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> MOVVER_VM_Datasource_Protocol?
}

public protocol MOVVER_CollectionVM_DatasourcePrefetching {
	func mv_collectionDatasource(prefetchItemsAt: [IndexPath])
	func mv_collectionDatasource(cancelPrefetchingForItemsAt: [IndexPath])
}

public protocol MOVVER_CollectionViewDataSourceDelegate {
	func mv_delegate(datasource: MOVVER_CollectionCell_Datasource, preBindCell: MOVVER_Cell_Datasource_Protocol, atIndexPath:IndexPath)
	func mv_delegate(datasource: MOVVER_CollectionCell_Datasource, postBindCell: MOVVER_Cell_Datasource_Protocol, atIndexPath:IndexPath)
	func mv_delegate(datasource: MOVVER_CollectionCell_Datasource, preBindSuplemementaryView: MOVVER_ReusableView_Datasource_Protocol, atIndexPath:IndexPath)
	func mv_delegate(datasource: MOVVER_CollectionCell_Datasource, postBindSuplementaryView: MOVVER_ReusableView_Datasource_Protocol, atIndexPath:IndexPath)
	
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
		let sectionCount = self.viewModelDataSource?.mv_collectionDatasource_numberOfSections()
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
		return viewModelDataSource?.mv_collectionDatasource(numberOfItemsInSection: section) ?? 0
	}
	
	open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let viewModel = self.viewModelDataSource?.mv_collectionDatasource(viewModelForItemAt: indexPath) {
			
			let identifier = viewModel.mv_identifier()
			let cell:C = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! C
			
			self.datasourceDelegate?.mv_delegate(datasource: self, preBindCell: cell, atIndexPath: indexPath)
			cell.mv_bind(viewModel: viewModel)
			viewModel.mv_generic_view = cell
			self.datasourceDelegate?.mv_delegate(datasource: self, postBindCell: cell, atIndexPath: indexPath)
			return cell
		}
		return UICollectionViewCell()
	}
	
	open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		guard let viewModelDataSourceSV = self.viewModelDataSource as? MOVVER_CollectionVM_DatasourceSupplementaryViews else {
			return UICollectionReusableView()
		}
		if let viewModel:MOVVER_ReusableViewModel_Datasource_Protocol = viewModelDataSourceSV.mv_collectionDatasource(viewModelForSupplementaryElementOfKind: kind, at: indexPath) as? MOVVER_ReusableViewModel_Datasource_Protocol{
			let identifier:String = viewModel.mv_identifier()
			let view:RV = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as! RV
			self.datasourceDelegate?.mv_delegate(datasource: self, preBindSuplemementaryView: view, atIndexPath: indexPath)
			view.mv_bind(viewModel: viewModel)
			viewModel.mv_generic_view = view
			self.datasourceDelegate?.mv_delegate(datasource: self, postBindSuplementaryView: view, atIndexPath: indexPath)
			return view;
			
		}
		return UICollectionReusableView()
	}
	
	open func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]){
		guard let prefetchigDatasource = self.viewModelDataSource as? MOVVER_CollectionVM_DatasourcePrefetching else { return }
		prefetchigDatasource.mv_collectionDatasource(prefetchItemsAt: indexPaths)
	}
	
	open func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]){
		guard let prefetchigDatasource = self.viewModelDataSource as? MOVVER_CollectionVM_DatasourcePrefetching else { return }
		prefetchigDatasource.mv_collectionDatasource(cancelPrefetchingForItemsAt: indexPaths)
	}
	
	
}



// MARK: Extension to provide a default implementation for all the datasource methods if not implemented

extension MOVVER_CollectionVM_Datasource{
	public func mv_collectionDatasource(numberOfItemsInSection section: Int) -> Int{
		return 0
	}
	public  func mv_collectionDatasource(viewModelForItemAt indexPath: IndexPath) -> MOVVER_VM_Datasource_Protocol{
		return MOVVER_CollectionCellViewModel()
	}
	public func mv_collectionDatasource_numberOfSections() -> Int{
		return 0
	}
	
	public func mv_collectionDatasource(canMoveItemAt indexPath: IndexPath) -> Bool { return false }
	public func mv_collectionDatasource(moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) { }
}

// MARK: Extension to provide a default implementation for all the prefetch methods if not implemented

extension MOVVER_CollectionVM_DatasourcePrefetching{
	public func mv_collectionDatasource(prefetchItemsAt: [IndexPath]) {}
	public func mv_collectionDatasource(cancelPrefetchingForItemsAt: [IndexPath]) {}
}



// MARK: Array helper

extension Array:MOVVER_CollectionVM_Datasource,MOVVER_CollectionVM_DatasourcePrefetching{
	public func mv_collectionDatasource(numberOfItemsInSection section: Int) -> Int{
		return self.count
	}
	public  func mv_collectionDatasource(viewModelForItemAt indexPath: IndexPath) -> MOVVER_VM_Datasource_Protocol{
		let viewModel:MOVVER_VM_Datasource_Protocol = self[indexPath.row] as! MOVVER_VM_Datasource_Protocol
		return viewModel
	}
	public func mv_collectionDatasource_numberOfSections() -> Int{
		return self.count>0 ? 1 : 0
	}
	
	public func mv_collectionDatasource(prefetchItemsAt: [IndexPath]) {
		for indexPath in prefetchItemsAt
		{
			if let viewModel = self[indexPath.row] as? MOVVER_VM_DatasourcePreload_Protocol {
				viewModel.mv_preload()
			}
			
		}
		
	}
	public func mv_collectionDatasource(cancelPrefetchingForItemsAt: [IndexPath]) {
		for indexPath in cancelPrefetchingForItemsAt
		{
			if let viewModel = self[indexPath.row] as? MOVVER_VM_DatasourcePreload_Protocol {
				viewModel.mv_cancelPreloading()
			}
			
		}
		
	}
}

// MARK: Cell Helper

open class MOVVER_CollectionViewCell:UICollectionViewCell,mv_vc,MOVVER_Cell_Datasource_Protocol{
	open var mv_generic_viewModel: mv_vm!
	open func mv_bind(viewModel: MOVVER_VM_Datasource_Protocol) {
		assertionFailure("ERROR: Implement this")
	}
}

// MARK: ReusableViewHelper

open class MOVVER_ReusableView: UICollectionReusableView,MOVVER_ReusableView_Datasource_Protocol {
	open var mv_generic_viewModel: mv_vm!
	open func mv_bind(viewModel: MOVVER_VM_Datasource_Protocol) {
		assertionFailure("ERROR: Implement this")
	}
	
}



// MARK: Cell ViewModel Helper

open class MOVVER_CollectionCellViewModel: mv_vm,MOVVER_VM_Datasource_Protocol,MOVVER_VM_DatasourcePreload_Protocol {
	public var mv_delegateViewModel: mv_vm!

	public var mv_generic_router: mv_rt!
	public var mv_generic_view: mv_vc!
	public var mv_generic_model: Any?
	
	public required init() {
	}
	public required init(model:Any?, delegateViewModel: mv_vm, router:mv_rt){
		self.mv_delegateViewModel = delegateViewModel
		self.mv_generic_model = model
		self.mv_generic_router = router
	}
	
	open func mv_identifier() -> String {
		assertionFailure("ERROR: Implement this")
		return ""
	}
	open func mv_preload() {
		print("Trying to preload \(self). Did you forget to implement this?")
	}
	open func mv_cancelPreloading() {
		print("Trying to cancel preload \(self). Did you forget to implement this?")
	}
}

// MARK: ReusableViewHelper ViewModel Helper

open class MOVVER_ReusableViewModel: mv_vm,MOVVER_ReusableViewModel_Datasource_Protocol {
	public var mv_delegateViewModel: mv_vm!
	
	public var mv_generic_router: mv_rt!
	public var mv_generic_view: mv_vc!
	public var mv_generic_model: Any?
	
	public required init() {
	}
	public required init(model:Any?, delegateViewModel: mv_vm, router:mv_rt){
		self.mv_delegateViewModel = delegateViewModel
		self.mv_generic_model = model
		self.mv_generic_router = router
	}
	
	open func mv_identifier() -> String {
		assertionFailure("ERROR: Implement this")
		return ""
	}
	open func mv_preload() {
		print("Trying to preload \(self). Did you forget to implement this?")
	}
	open func mv_cancelPreloading() {
		print("Trying to cancel preload \(self). Did you forget to implement this?")
	}
}
