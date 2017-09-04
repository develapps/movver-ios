//
//  ViewModel.swift
//  movver-ios
//
//  Created by Pablo Romeu on 15/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Movver


//--------------------------------------------------------
// MARK: viewmodel class
//--------------------------------------------------------
class ViewModel: mv_vm{
	var mv_generic_model: Any?
	var mv_generic_view: mv_vc!
	var mv_generic_router: mv_rt!
	required init() {
		
	}
}

//--------------------------------------------------------
// MARK: MOVVER viewmodel concrete properties
//--------------------------------------------------------


extension ViewModel: mv_viewModel{
	func mv_view() -> ViewControllerProtocol {
		return self.mv_generic_view as! ViewControllerProtocol
	}
	func mv_model() -> Any? {
		return self.mv_generic_model as Any?
	}
	func mv_router() -> RouterProtocol {
		return self.mv_generic_router as! RouterProtocol
	}
}
//--------------------------------------------------------
// MARK:  protocol to be implemented by the viewmodel
//--------------------------------------------------------

protocol ViewModelProtocol:mv_vm{
	func showAlert()
	func showCollection()
	func showTable()
}

//--------------------------------------------------------
// MARK: implementation of the protocol
//--------------------------------------------------------

extension ViewModel: ViewModelProtocol{
	func showAlert(){
		print("Alert")
		self.mv_router().showAlert(alertString: "Alert shown!")
	}
	func showCollection(){
		print("Collection")
		self.mv_router().showCollection()
	}
	func showTable()
	{
		print("Table")
		self.mv_router().showTableView()
	}
}
