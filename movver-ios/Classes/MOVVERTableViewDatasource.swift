//
//  MOVVERTableViewDatasource.swift
//  Santoral Pro
//
//  Created by Pablo Romeu on 8/7/16.
//  Copyright © 2016 Pablo Romeu. All rights reserved.
//

import Foundation

// MARK:
// MARK: Table Datasource


protocol MOVVER_TableCell_Datasource {
    var viewModelDataSource:MOVVER_TableVM_Datasource? { get set }
}

protocol MOVVER_TableVM_Datasource {
    func movver_tableDatasource(numberOfCellsInSection section: Int) -> Int
    func movver_tableDatasource(viewModelForCellAt indexPath: IndexPath) -> MOVVER_VM_Datasource_Protocol
    func movver_tableDatasource_numberOfSections() -> Int
    
    func movver_tableDatasource(titleForHeaderInSection section: Int) -> String?
    func movver_tableDatasource(titleForFooterInSection section: Int) -> String?
    
    func movver_tableDatasource(canEditRowAt indexPath: IndexPath) -> Bool
    func movver_tableDatasource(canMoveCellAt indexPath: IndexPath) -> Bool
    func movver_tableDatasource(moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    
    func movver_tableDatasource_sectionIndexTitles() -> [String]?
    func movver_tableDatasource(sectionForSectionIndexTitle title: String, at index: Int) -> Int
    
    func movver_tableDatasource(commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    
}

protocol MOVVER_TableVM_DatasourcePrefetching {
    func movver_tableDatasource(prefetchRowsAt: [IndexPath])
    func movver_tableDatasource(cancelPrefetchingForRowsAt: [IndexPath])
}

protocol MOVVER_TableViewDataSourceDelegate {
    func movver_delegate(datasource: MOVVER_TableCell_Datasource, preBindCell: MOVVER_Cell_Datasource_Protocol, atIndexPath:IndexPath)
    func movver_delegate(datasource: MOVVER_TableCell_Datasource, postBindCell: MOVVER_Cell_Datasource_Protocol, atIndexPath:IndexPath)
}


class MOVVER_TableViewDataSource<C>:NSObject,UITableViewDataSource,MOVVER_TableCell_Datasource,UITableViewDataSourcePrefetching
                                where C:UITableViewCell,C:MOVVER_Cell_Datasource_Protocol{
    
    var noDataView:UIView?
    private var oldView:UIView?
    var viewModelDataSource:MOVVER_TableVM_Datasource?
    var datasourceDelegate:MOVVER_TableViewDataSourceDelegate?
    
    init(viewModelDataSource: MOVVER_TableVM_Datasource) {
        self.viewModelDataSource = viewModelDataSource
    }
    
    convenience init(viewModelDataSource: MOVVER_TableVM_Datasource, datasourceDelegate:MOVVER_TableViewDataSourceDelegate) {
        self.init(viewModelDataSource:viewModelDataSource)
        self.datasourceDelegate = datasourceDelegate
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let sectionCount = self.viewModelDataSource?.movver_tableDatasource_numberOfSections()
        if (sectionCount==0) {
            if  (self.noDataView != nil ) &&
                (tableView.backgroundView != self.noDataView)
            {
                self.oldView = tableView.backgroundView;
                tableView.backgroundView = self.noDataView;
            }
        }
        else if (tableView.backgroundView == self.noDataView){
            tableView.backgroundView = self.oldView;
        }
        return sectionCount ?? 0;
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return viewModelDataSource?.movver_tableDatasource(numberOfCellsInSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if let viewModel = self.viewModelDataSource?.movver_tableDatasource(viewModelForCellAt: indexPath) {
            
            let identifier = viewModel.movver_identifier()
            let cell:C = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! C
            
            self.datasourceDelegate?.movver_delegate(datasource: self, preBindCell: cell, atIndexPath: indexPath)
            cell.movver_bind(viewModel: viewModel)
            self.datasourceDelegate?.movver_delegate(datasource: self, postBindCell: cell, atIndexPath: indexPath)
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return self.viewModelDataSource?.movver_tableDatasource(titleForHeaderInSection: section)
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?{
        return self.viewModelDataSource?.movver_tableDatasource(titleForFooterInSection: section)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]?
    {
        return self.viewModelDataSource?.movver_tableDatasource_sectionIndexTitles() ?? nil
    }
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int{
        return self.viewModelDataSource?.movver_tableDatasource(sectionForSectionIndexTitle: title, at: index) ?? 0
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        self.viewModelDataSource?.movver_tableDatasource(commit: editingStyle, forRowAt: indexPath)
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        self.viewModelDataSource?.movver_tableDatasource(moveRowAt: sourceIndexPath, to: destinationIndexPath)
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return (self.viewModelDataSource?.movver_tableDatasource(canEditRowAt: indexPath)) ?? false
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool{
        return (self.viewModelDataSource?.movver_tableDatasource(canMoveCellAt: indexPath)) ?? false
    }
    
    
    // MARK: Prefetching
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let prefetchingDatasource = self as? MOVVER_TableVM_DatasourcePrefetching else { return }
        prefetchingDatasource.movver_tableDatasource(prefetchRowsAt: indexPaths)
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        guard let prefetchingDatasource = self as? MOVVER_TableVM_DatasourcePrefetching else { return }
        prefetchingDatasource.movver_tableDatasource(cancelPrefetchingForRowsAt: indexPaths)
    }
    
    
}
//
// MARK: Array helper

extension Array:MOVVER_TableVM_Datasource,MOVVER_TableVM_DatasourcePrefetching{
    func movver_tableDatasource(numberOfCellsInSection section: Int) -> Int {
        return self.count
    }
    func movver_tableDatasource(viewModelForCellAt indexPath: IndexPath) -> MOVVER_VM_Datasource_Protocol {
        let viewModel:MOVVER_VM_Datasource_Protocol = self[indexPath.row] as! MOVVER_VM_Datasource_Protocol
        return viewModel
    }
    func movver_tableDatasource_numberOfSections() -> Int{
        return self.count>0 ? 1 : 0
    }
    
    // No implementation for this 
    
    func movver_tableDatasource(titleForHeaderInSection section: Int) -> String? { return nil }
    func movver_tableDatasource(titleForFooterInSection section: Int) -> String? { return nil }
    func movver_tableDatasource(canEditRowAt indexPath: IndexPath) -> Bool { return false }
    func movver_tableDatasource(canMoveCellAt indexPath: IndexPath) -> Bool { return false }
    func movver_tableDatasource(moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) { }
    func movver_tableDatasource_sectionIndexTitles() -> [String]? { return nil }
    func movver_tableDatasource(sectionForSectionIndexTitle title: String, at index: Int) -> Int { return 0 }
    func movver_tableDatasource(commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {  }
    
    func movver_tableDatasource(prefetchRowsAt: [IndexPath]) {
        for indexPath in prefetchRowsAt
        {
            if let viewModel = self[indexPath.row] as? MOVVER_VM_DatasourcePreload_Protocol {
                viewModel.movver_preload()
            }

        }

    }
    func movver_tableDatasource(cancelPrefetchingForRowsAt: [IndexPath]) {
        for indexPath in cancelPrefetchingForRowsAt
        {
            if let viewModel = self[indexPath.row] as? MOVVER_VM_DatasourcePreload_Protocol {
                viewModel.movver_cancelPreloading()
            }

        }

    }
}

// MARK: Cell Helper

class MOVVER_TableViewCell:UITableViewCell,MOVVER_VC_Protocol,MOVVER_Cell_Datasource_Protocol{

    var delegateViewModel:MOVVER_VM_Protocol?

    func movver_bind(viewModel: MOVVER_VM_Datasource_Protocol) {
        assertionFailure("ERROR: Implement this")
    }
    func movver_VM_Call(event: Any){
        assertionFailure("ERROR: Implement this")
    }

}


// MARK: Cell ViewModel Helper

class MOVVER_TableCellViewModel: MOVVER_VM,MOVVER_VM_Datasource_Protocol,MOVVER_VM_DatasourcePreload_Protocol {
    func movver_identifier() -> String {
        assertionFailure("ERROR: Implement this")
        return ""
    }
    func movver_preload() {    }
    func movver_cancelPreloading() { }
}


