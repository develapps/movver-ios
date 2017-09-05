//
//  MOVVERDatasources.swift
//
//  Created by Pablo Romeu on 6/7/16.
//  Copyright © 2016 Pablo Romeu. All rights reserved.
//

import Foundation



// MARK: Datasource protocols

/*
 These protocols accomplish the model and viewController protocols
 */

public protocol MOVVER_VM_Datasource_Protocol:mv_vm {
	var mv_delegateViewModel:   mv_vm! { get set }
    init(model:Any?, delegateViewModel: mv_vm, router:mv_rt)
    func mv_identifier() -> String
}

public protocol MOVVER_VM_DatasourcePreload_Protocol:MOVVER_VM_Datasource_Protocol {
    func mv_preload()
    func mv_cancelPreloading()
}


public protocol MOVVER_Cell_Datasource_Protocol:mv_vc {
    func mv_bind(viewModel:MOVVER_VM_Datasource_Protocol)
}


/// A protocol to specify the type of the generic storage properties
public protocol mv_cellviewModel: mv_viewModel{
	associatedtype DELEGATEVM
	associatedtype RT
	associatedtype MODEL
	
	/// The concrete delegate ViewModel
	///
	/// - Returns: returns a concrete viewModel
	func mv_delegateViewModel()-> DELEGATEVM
}
