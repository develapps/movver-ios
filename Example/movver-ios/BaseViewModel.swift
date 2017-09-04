//
//  BaseViewModel.swift
//  movver-ios
//
//  Created by Pablo Romeu on 4/9/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Movver
//--------------------------------------------------------
// MARK: viewmodel class
//--------------------------------------------------------


class BaseViewModel: mv_vm {
	var mv_generic_view: mv_vc!
	var mv_generic_router: mv_rt!
	var mv_generic_model: Any?
	required init() {
		
	}
}
