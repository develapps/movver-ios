//
//  Router.swift
//  movver-ios
//
//  Created by Pablo Romeu on 15/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Movver



protocol RouterProtocol:mv_rt {
	
}

class Router: mv_rt{
	var mv_generic_previousRouter: mv_rt?
	var mv_generic_view: mv_vc!
	var mv_generic_viewModel: mv_vm!
}


extension Router: mv_router{
	func mv_view() -> ViewControllerProtocol {
		return self.mv_generic_view as! ViewControllerProtocol
	}
	func mv_viewModel() ->  ViewModelProtocol{
		return self.mv_generic_viewModel as! ViewModelProtocol
	}
	func mv_previousRouter() -> Any? {
		return nil
	}
}


extension Router: RouterProtocol{
	
}

