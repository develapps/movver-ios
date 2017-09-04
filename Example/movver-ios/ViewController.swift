//
//  ViewController.swift
//  movver-ios
//
//  Created by Pablo Romeu on 09/15/2016.
//  Copyright (c) 2016 Pablo Romeu. All rights reserved.
//

import UIKit
import Movver

//--------------------------------------------------------
// MARK: viewcontroller class
//--------------------------------------------------------


class ViewController: BaseViewController {
	@IBOutlet weak var aButton: UIButton!

}


//--------------------------------------------------------
// MARK: MOVVER viewcontroller concrete properties
//--------------------------------------------------------

extension ViewController: mv_view{
	func mv_viewModel() -> ViewModelProtocol {
		return self.mv_generic_viewModel as! ViewModelProtocol
	}
}

//--------------------------------------------------------
// MARK:  protocol to be implemented by the viewcontroller
//--------------------------------------------------------


protocol ViewControllerProtocol:mv_vc{
	
}
//--------------------------------------------------------
// MARK: implementation of the protocol
//--------------------------------------------------------

extension ViewController: ViewControllerProtocol {
	
}
