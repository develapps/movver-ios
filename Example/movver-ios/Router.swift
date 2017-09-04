//
//  Router.swift
//  movver-ios
//
//  Created by Pablo Romeu on 15/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Movver

//--------------------------------------------------------
// MARK: router class
//--------------------------------------------------------
class Router: BaseRouter{
	
}

//--------------------------------------------------------
// MARK: MOVVER router concrete properties
//--------------------------------------------------------
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

//--------------------------------------------------------
// MARK:  protocol to be implemented by the router
//--------------------------------------------------------

protocol RouterProtocol:mv_rt {
	
}

//--------------------------------------------------------
// MARK: implementation of the protocol
//--------------------------------------------------------

extension Router: RouterProtocol{
	
}

