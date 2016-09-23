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



public protocol MOVVER_RT_Protocol: class {
    var movver_currentController   :   MOVVER_VC_Protocol? { get set }
    var movver_viewModel           :   MOVVER_VM_Protocol? { get set }
    var movver_previousRouter      :   MOVVER_RT_Protocol? { get set }
    
    func movver_VM_Call(event: Any)
}


// MARK: _VM_


public protocol MOVVER_VM_Protocol: class{
    var movver_delegateView            :   MOVVER_VC_Protocol? { get set }
    var movver_delegateRouter          :   MOVVER_RT_Protocol? { get set }
    var movver_model                   :   Any? { get set }
    init()
    func movver_VC_Call(event: Any)
    func movver_RT_Call(event: Any)
}

// MARK: _VC_

public protocol MOVVER_VC_Protocol: class {
    var movver_delegateViewModel:MOVVER_VM_Protocol? { get set }
    func movver_VM_Call(event: Any)
}

// MARK: _Helper clases_


open class MOVVER_RT:MOVVER_RT_Protocol {
    public var movver_currentController   :   MOVVER_VC_Protocol?
    public var movver_viewModel           :   MOVVER_VM_Protocol?
    public var movver_previousRouter      :   MOVVER_RT_Protocol?
    public init() {}
    open func movver_VM_Call(event: Any){
        preconditionFailure("MOVVER: You must implement this")
    }

}

open class MOVVER_VM:MOVVER_VM_Protocol {
    
    public var movver_delegateView            :   MOVVER_VC_Protocol?
    public var movver_delegateRouter          :   MOVVER_RT_Protocol?
    public var movver_model                   :   Any?
    public required init() {}
    public init(model:Any?, delegate: MOVVER_VC_Protocol?, router:MOVVER_RT_Protocol?){
        self.movver_model = model
        self.movver_delegateView = delegate
        self.movver_delegateRouter = router
    }
    open func movver_VC_Call(event: Any){
        preconditionFailure("MOVVER: You must implement this")
    }
    open func movver_RT_Call(event: Any){
        preconditionFailure("MOVVER: You must implement this")
    }
    
}



open class MOVVER_VC:UIViewController,MOVVER_VC_Protocol{
    public var movver_delegateViewModel:MOVVER_VM_Protocol?
    open func movver_VM_Call(event: Any){
        preconditionFailure("MOVVER: You must implement this")
    }
}


// MARK: _EXTENSION_

public extension MOVVER_RT {

    public func movver_VC_Instantiate<VC,VM>(model:Any?, viewModelClass:VM.Type, storyboard:UIStoryboard,identifier:String,previousRouter:MOVVER_RT_Protocol?) -> VC where VC:MOVVER_VC,VM:MOVVER_VM_Protocol {
        
        // Save previous router
        
        self.movver_previousRouter = previousRouter
        
        // Instantiate View Controller
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! VC
        
        // Create VM and pass the model, the router and controller
        
        let viewModel:VM = VM()
        viewModel.movver_model = model
        viewModel.movver_delegateView = viewController
        viewModel.movver_delegateRouter = self
        self.movver_viewModel = viewModel
        viewController.movver_delegateViewModel = self.movver_viewModel
        
        self.movver_currentController = viewController
        
        return viewController
    }
    
}


