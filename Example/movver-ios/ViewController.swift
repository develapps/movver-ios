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


class ViewController: UIViewController,mv_vc {
	var mv_generic_viewModel: mv_vm!
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
	func didPressAlert(_ element: UIButton)
	func didPressCollection(_ element: UIButton)
	func didPressTable(_ element: UIButton)
}

extension ViewControllerProtocol where Self:UIViewController{
	
}

//--------------------------------------------------------
// MARK: implementation of the protocol
//--------------------------------------------------------

extension ViewController: ViewControllerProtocol {
	@IBAction func didPressAlert(_ element: UIButton){
		self.mv_viewModel().showAlert()
	}
	@IBAction func didPressCollection(_ element: UIButton){
		self.mv_viewModel().showCollection()
	}
	@IBAction func didPressTable(_ element: UIButton){
		self.mv_viewModel().showTable()
	}
}
