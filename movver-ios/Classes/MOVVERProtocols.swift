//
//  MOVVERProtocols.swift
//  Santoral Pro
//
//  Created by Pablo Romeu on 5/7/16.
//  Copyright © 2016 Pablo Romeu. All rights reserved.
//

import Foundation
import UIKit

// MARK: Debug 


public enum MOVVER_Debug:Int {
    case Error
    case Info
    case Verbose
}

public var movver_debug:MOVVER_Debug = .Error


// MARK: _RT_

/*
 Router:
 
 - Routes the
 */



protocol MOVVER_RT_Protocol {
    var currentController   :   MOVVER_VC_Protocol? { get set }
    var viewModel           :   MOVVER_VM_Protocol? { get set }
    var previousRouter      :   MOVVER_RT_Protocol? { get set }

    func movver_VM_Call(event: Any)
}


class MOVVER_RT<VC,VM,M>:MOVVER_RT_Protocol
                where VC:MOVVER_VC_Protocol,VC:UIViewController,VM:MOVVER_VM_Protocol{
    var currentController   :   MOVVER_VC_Protocol?
    var viewModel           :   MOVVER_VM_Protocol?
    var previousRouter      :   MOVVER_RT_Protocol?

    var unwrappedController:VC {
        get{
            return currentController as! VC
        }
    }
    var unwrappedViewModel:VM{
        get {
            return viewModel as! VM
        }
    }
    
    func movver_VC_Instantiate(model:M?, storyboard:UIStoryboard,identifier:String,previousRouter:MOVVER_RT_Protocol?) -> VC{
        
        // Save previous router
        
        self.previousRouter = previousRouter
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! VC
        
        // Create VM and pass the model, the router and controller
        var viewModel:VM = VM()
        viewModel.model = model
        viewModel.delegateView = viewController
        viewModel.delegateRouter = self
        self.viewModel = viewModel
        viewController.delegateViewModel = self.unwrappedViewModel
        
        self.currentController = viewController
        
        return viewController
    }
    
    func movver_VM_Call(event: Any){
        preconditionFailure("MOVVER: You must implement this")
    }
    
}

// MARK: _VM_


protocol MOVVER_VM_Protocol {
    var delegateView            :   MOVVER_VC_Protocol? { get set }
    var delegateRouter          :   MOVVER_RT_Protocol? { get set }
    var model                   :   Any? { get set }
    init()
    func movver_VC_Call(event: Any)
    func movver_RT_Call(event: Any)
}

class MOVVER_VM:MOVVER_VM_Protocol {
    var delegateView            :   MOVVER_VC_Protocol?
    var delegateRouter          :   MOVVER_RT_Protocol?
    var model                   :   Any?
    required init() {}
    required init(model:Any?, delegate: MOVVER_VC_Protocol?, router:MOVVER_RT_Protocol?){
        self.model = model
        self.delegateView = delegate
        self.delegateRouter = router
    }
    func movver_VC_Call(event: Any){
        preconditionFailure("MOVVER: You must implement this")
    }
    func movver_RT_Call(event: Any){
        preconditionFailure("MOVVER: You must implement this")
    }

}

// MARK: _VC_

protocol MOVVER_VC_Protocol {
    var delegateViewModel:MOVVER_VM_Protocol? { get set }
    func movver_VM_Call(event: Any)
}


class MOVVER_VC:UIViewController,MOVVER_VC_Protocol{
    var delegateViewModel:MOVVER_VM_Protocol?
    func movver_VM_Call(event: Any){
        preconditionFailure("MOVVER: You must implement this")
    }
}

