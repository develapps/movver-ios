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
 
 - Routes the navigation, alerts, etc
 */



public protocol MOVVER_RT_Protocol {
    var currentController   :   MOVVER_VC_Protocol? { get set }
    var viewModel           :   MOVVER_VM_Protocol? { get set }
    var previousRouter      :   MOVVER_RT_Protocol? { get set }
    
    func movver_VM_Call(event: Any)
}


// MARK: _VM_


public protocol MOVVER_VM_Protocol {
    var delegateView            :   MOVVER_VC_Protocol? { get set }
    var delegateRouter          :   MOVVER_RT_Protocol? { get set }
    var model                   :   Any? { get set }
    init()
    func movver_VC_Call(event: Any)
    func movver_RT_Call(event: Any)
}

// MARK: _VC_

public protocol MOVVER_VC_Protocol {
    var delegateViewModel:MOVVER_VM_Protocol? { get set }
    func movver_VM_Call(event: Any)
}

// MARK: _Helper clases_


open class MOVVER_RT:MOVVER_RT_Protocol {
    public var currentController   :   MOVVER_VC_Protocol?
    public var viewModel           :   MOVVER_VM_Protocol?
    public var previousRouter      :   MOVVER_RT_Protocol?
    
    public init() {}
    open func movver_VM_Call(event: Any){
        preconditionFailure("MOVVER: You must implement this")
    }

}

open class MOVVER_VM:MOVVER_VM_Protocol {
    public var delegateView            :   MOVVER_VC_Protocol?
    public var delegateRouter          :   MOVVER_RT_Protocol?
    public var model                   :   Any?
    public required init() {}
    public required init(model:Any?, delegate: MOVVER_VC_Protocol?, router:MOVVER_RT_Protocol?){
        self.model = model
        self.delegateView = delegate
        self.delegateRouter = router
    }
    open func movver_VC_Call(event: Any){
        preconditionFailure("MOVVER: You must implement this")
    }
    open func movver_RT_Call(event: Any){
        preconditionFailure("MOVVER: You must implement this")
    }
    
}



open class MOVVER_VC:UIViewController,MOVVER_VC_Protocol{
    public var delegateViewModel:MOVVER_VM_Protocol?
    open func movver_VM_Call(event: Any){
        preconditionFailure("MOVVER: You must implement this")
    }
}


// MARK: _EXTENSION_

public extension MOVVER_RT {
    
    public func movver_VC_Instantiate<VC,VM>(model:Any?, viewModelClass:VM.Type, storyboard:UIStoryboard,identifier:String,previousRouter:MOVVER_RT_Protocol?) -> VC where VC:MOVVER_VC,VM:MOVVER_VM_Protocol {
        
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
        viewController.delegateViewModel = self.viewModel
        
        self.currentController = viewController
        
        return viewController
    }
    
}


