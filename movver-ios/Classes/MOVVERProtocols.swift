//
//  MOVVERProtocols.swift
//
//  Created by Pablo Romeu on 5/7/16.
//  Copyright © 2016 Pablo Romeu. All rights reserved.
//

import Foundation
import UIKit

/*
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
    var movver_currentController   :   MOVVER_VC_Protocol! { get set }
    var movver_viewModel           :   MOVVER_VM_Protocol! { get set }
    var movver_previousRouter      :   MOVVER_RT_Protocol! { get set }
    
    func movver_VM_Call(event: Any)
    func movver_tellViewModel(event: Any)
}


// MARK: _VM_


public protocol MOVVER_VM_Protocol: class{
     var movver_delegateView            :   MOVVER_VC_Protocol! { get set }
     var movver_delegateRouter          :   MOVVER_RT_Protocol! { get set }
    var movver_model                   :   Any? { get set }
    init()
    func movver_VC_Call(event: Any)
    func movver_tellViewController(event: Any)
    func movver_RT_Call(event: Any)
    func movver_tellRouter(event: Any)
}

// MARK: _VC_

public protocol MOVVER_VC_Protocol: class {
     var movver_delegateViewModel:MOVVER_VM_Protocol! { get set }
    func movver_VM_Call(event: Any)
    func movver_tellViewModel(event: Any)
}

// MARK: _Helper clases_

//--------------------------------------------------------
// MARK: Deep linking
//--------------------------------------------------------


/// This protocol implements two methods to route through the app to a specific screen
protocol MOVVER_DeepLinking_Protocol{
	
	/// Tells whether a specific router
	///
	/// - Parameter url: the url to route to
	/// - Returns: Whether the route is known
	func movver_canRouteTo(url: URL) -> Bool
	
	/// This method routes to the destination viewController
	///
	/// - Parameters:
	///   - url: the url to route to
	///   - animated: whether the route should be animated or not
	///   - model: if a model should be attached
	func movver_routeToDestination(url:URL, animated:Bool, model:Any?)
}

// MARK: _RT_

open class MOVVER_RT:MOVVER_RT_Protocol,MOVVER_DeepLinking_Protocol {
    public var movver_currentController   :   MOVVER_VC_Protocol!
    public var movver_viewModel           :   MOVVER_VM_Protocol!
    public var movver_previousRouter      :   MOVVER_RT_Protocol!
    public init() {}
    open func movver_VM_Call(event: Any){
        preconditionFailure("MOVVER: You must implement this")
    }
    public func movver_tellViewModel(event: Any) {
        self.movver_viewModel?.movver_RT_Call(event: event)
    }
	open func movver_canRouteTo(url: URL) -> Bool{
		return false
	}
	open func movver_routeToDestination(url:URL, animated:Bool, model:Any?){
		// No implementation
	}


}

open class MOVVER_VM:MOVVER_VM_Protocol {
    
    public  var movver_delegateView            :   MOVVER_VC_Protocol!
    public  var movver_delegateRouter          :   MOVVER_RT_Protocol!
    public var movver_model                   :   Any?
    public required init() {}
    public init(model:Any?, delegate: MOVVER_VC_Protocol, router:MOVVER_RT_Protocol){
        self.movver_model = model
        self.movver_delegateView = delegate
        self.movver_delegateRouter = router
    }
    open func movver_VC_Call(event: Any){
        preconditionFailure("MOVVER: You must implement this")
    }
    public func movver_tellViewController(event: Any) {
        self.movver_delegateView?.movver_VM_Call(event: event)
    }
    
    open func movver_RT_Call(event: Any){
        preconditionFailure("MOVVER: You must implement this")
    }
    public func movver_tellRouter(event: Any) {
        self.movver_delegateRouter?.movver_VM_Call(event: event)
    }
	
	
}



open class MOVVER_VC:UIViewController,MOVVER_VC_Protocol{
    public  var movver_delegateViewModel:MOVVER_VM_Protocol!
    open func movver_VM_Call(event: Any){
        preconditionFailure("MOVVER: You must implement this")
    }
    public func movver_tellViewModel(event: Any) {
        self.movver_delegateViewModel?.movver_VC_Call(event: event)
    }
}



// MARK: _EXTENSION_

public extension MOVVER_RT {
	
    /// Instantiates and binds all movver objects together
    ///
    /// - Parameters:
	///   - model: the model, if any
	///   - viewModelClass: the viewModel class to be instantiated
    ///   - storyboard: the storyboard instance
    ///   - identifier: the identifier of the View Controller at the storyBoard
	///   - previousRouter: the previous router
    /// - Returns: the View Controller instantiated
	
    public func movver_VC_Instantiate<VC,VM>(model:Any?, viewModelClass:VM.Type, storyboard:UIStoryboard,identifier:String,previousRouter:MOVVER_RT_Protocol?) -> VC where VC:MOVVER_VC,VM:MOVVER_VM_Protocol {
        // Instantiate View Controller
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! VC
        self.movver_VC_Bind(model: model, viewModelClass: viewModelClass, viewController: viewController, previousRouter: previousRouter)
        return viewController
    }
	
    /// Binds all the movver objects
    ///
    /// - Parameters:
    ///   - model: the model, if any
    ///   - viewModelClass: the viewModel class to be instantiated
    ///   - viewController: the view controller
    ///   - previousRouter: the previous router
	
    public func movver_VC_Bind<VC,VM>(model:Any?, viewModelClass:VM.Type, viewController:VC ,previousRouter:MOVVER_RT_Protocol?)  where VC:MOVVER_VC,VM:MOVVER_VM_Protocol {
        // Save previous router
        
        self.movver_previousRouter = previousRouter
        
        // Create VM and pass the model, the router and controller
        
        let viewModel:VM = VM()
        viewModel.movver_model = model
        viewModel.movver_delegateView = viewController
        viewModel.movver_delegateRouter = self
        self.movver_viewModel = viewModel
        viewController.movver_delegateViewModel = self.movver_viewModel
        
        self.movver_currentController = viewController
    }
    
}

*/
