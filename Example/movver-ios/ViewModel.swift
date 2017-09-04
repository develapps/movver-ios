//
//  ViewModel.swift
//  movver-ios
//
//  Created by Pablo Romeu on 15/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Movver

protocol ViewModelProtocol:mv_vm{
	
}

class ViewModel: mv_vm{
	var mv_generic_model: Any?
	var mv_generic_view: mv_vc!
	var mv_generic_router: mv_rt!
	required init() {
		
	}
}


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


extension ViewModel: ViewModelProtocol{
	
}
