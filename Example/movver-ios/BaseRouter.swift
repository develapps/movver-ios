//
//  BaseRouter.swift
//  movver-ios
//
//  Created by Pablo Romeu on 4/9/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Movver

//--------------------------------------------------------
// MARK: router class
//--------------------------------------------------------
class BaseRouter: mv_rt,mv_rt_imp{
	var mv_generic_previousRouter: mv_rt?
	var mv_generic_view: mv_vc!
	var mv_generic_viewModel: mv_vm!
}
