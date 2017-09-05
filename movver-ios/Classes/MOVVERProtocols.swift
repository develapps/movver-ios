//
//  Protocols
//  Pods
//
//  Created by Pablo Romeu on 4/9/17.
//
//

import UIKit


/// Router storage
public protocol mv_rt{
	/// Current View or view controller
	weak var mv_generic_view: mv_vc! { get set }
	
	/// The associated viewModel
	weak var mv_generic_viewModel: mv_vm! { get set }
	
	/// The previous router
	var mv_generic_previousRouter: mv_rt? { get set }
}

/// The viewModel storage
public protocol mv_vm:class{
	/// We must be able to instantiate it generically
	init()
	
	/// The model, if any
	var mv_generic_model: Any? { get set }
	
	/// The view associated with the viewModel
	weak var mv_generic_view: mv_vc! { get set }
	
	/// The router
	var mv_generic_router: mv_rt! { get set }
}


/// The viewController storage
public protocol mv_vc:class{
	
	/// The viewModel of the viewController
	var mv_generic_viewModel: mv_vm! { get set }
}

/// A protocol to specify the type of the generic storage properties
public protocol mv_view: mv_vc{
	associatedtype VM
	
	/// The view concrete viewModel
	///
	/// - Returns: the view model
	func mv_viewModel()-> VM
}

/// A protocol to specify the type of the generic storage properties
public protocol mv_viewModel: mv_vm{
	associatedtype VC
	associatedtype RT
	associatedtype MODEL
	
	/// The concrete view
	///
	/// - Returns: returns a concrete view
	func mv_view()-> VC
	
	/// The concrete router
	///
	/// - Returns: returns a concrete router
	func mv_router()-> RT
	
	/// The concrete model
	///
	/// - Returns: returns the concrete type of the model
	func mv_model()-> MODEL?
}
/// A protocol to specify the type of the generic storage properties
public protocol mv_router: mv_rt{
	associatedtype VC
	associatedtype RT
	associatedtype VM
	/// The concrete view
	///
	/// - Returns: returns a concrete view
	func mv_view() -> VC
	/// The view concrete viewModel
	///
	/// - Returns: the view model
	func mv_viewModel() -> VM
	/// The concrete previous router
	///
	/// - Returns: returns a concrete previous router
	func mv_previousRouter() -> RT?
}




/// This implements the instatiation of each case with router, model, viewmodel and controller
public protocol mv_rt_imp: mv_rt{
	mutating func movver_VC_Instantiate<VC,VM>(model:Any?, viewModelClass:VM.Type, storyboard:UIStoryboard,identifier:String,previousRouter:mv_rt?) -> VC where VC:mv_vc,VC:UIViewController,VM:mv_vm
	mutating func movver_VC_Bind<VC,VM>(model:Any?,  viewModelClass:VM.Type, viewController:VC ,previousRouter:mv_rt?) where VC:mv_vc,VC:UIViewController,VM:mv_vm
}


// MARK: - public implementation
public extension mv_rt_imp{
	mutating func movver_VC_Instantiate<VC,VM>(model:Any?, viewModelClass:VM.Type, storyboard:UIStoryboard,identifier:String,previousRouter:mv_rt?) -> VC where VC:mv_vc,VC:UIViewController,VM:mv_vm{
		// Instantiate View Controller
		let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! VC
		self.movver_VC_Bind(model: model, viewModelClass: viewModelClass, viewController: viewController, previousRouter: previousRouter)
		return viewController
	}

	
	mutating func movver_VC_Bind<VC,VM>(model:Any?,  viewModelClass:VM.Type, viewController:VC ,previousRouter:mv_rt?) where VC:mv_vc,VC:UIViewController,VM:mv_vm
	{
		// Save previous router
		
		self.mv_generic_previousRouter = previousRouter
		
		// Create VM and pass the model, the router and controller
		let viewModel = VM()
		viewModel.mv_generic_model = model
		viewModel.mv_generic_view = viewController
		viewModel.mv_generic_router = self
		self.mv_generic_viewModel = viewModel
		viewController.mv_generic_viewModel = self.mv_generic_viewModel
		self.mv_generic_view = viewController
	}
}




// MARK: _Helper clases_

//--------------------------------------------------------
// MARK: Deep linking
//--------------------------------------------------------


/// This protocol implements two methods to route through the app to a specific screen
public protocol mv_DeepLinking_Protocol{
	
	/// Tells whether a specific router
	///
	/// - Parameter url: the url to route to
	/// - Returns: Whether the route is known
	func mv_canRouteTo(url: URL) -> Bool
	
	/// This method routes to the destination viewController
	///
	/// - Parameters:
	///   - url: the url to route to
	///   - animated: whether the route should be animated or not
	///   - model: if a model should be attached
	func mv_routeToDestination(url:URL, animated:Bool, model:Any?)
}



/// Default implementation of the protocol
public extension mv_DeepLinking_Protocol{
	func movver_canRouteTo(url: URL) -> Bool{
		return false
	}
	func movver_routeToDestination(url:URL, animated:Bool, model:Any?){
		// No implementation
	}
}



//--------------------------------------------------------
// MARK: helper classes -> This classes implement basic functionality and store properties
//--------------------------------------------------------

open class MOVVER_RT:mv_rt,mv_rt_imp,mv_DeepLinking_Protocol {
	public var mv_generic_view: mv_vc!
	public var mv_generic_viewModel: mv_vm!
	public var mv_generic_previousRouter: mv_rt?
	public init() {}
	open func mv_canRouteTo(url: URL) -> Bool{
		return false
	}
	open func mv_routeToDestination(url:URL, animated:Bool, model:Any?){
		// No implementation
	}
	
}

open class MOVVER_VM:mv_vm {
	public var mv_generic_view: mv_vc!
	public var mv_generic_model: Any?
	public var mv_generic_router: mv_rt!
	
	
	public required init() {}
	public init(model:Any?, delegate: mv_vc, router:mv_rt){
		self.mv_generic_model = model
		self.mv_generic_view = delegate
		self.mv_generic_router = router
	}
}



open class MOVVER_VC:UIViewController,mv_vc{
	public var mv_generic_viewModel: mv_vm!
}



/*

SAMPLE USAGE

class MyVC:UIViewController,mv_vc{
var mv_generic_viewModel: mv_vm!


}

class MyVM:mv_vm{
var mv_generic_model: Any?
var mv_generic_router: mv_rt!
var mv_generic_view: mv_vc!
}

class MyRT:mv_rt,mv_rt_imp{
var mv_generic_previousRouter: mv_rt?
var mv_generic_view: mv_vc!
var mv_generic_viewModel: mv_vm!
}


protocol MyGenericVC:class,mv_vc{
func reloadTableView()
}

protocol MyGenericVM:class,mv_vm{
func tableReloaded()
}


extension MyVC:mv_view{
func mv_viewModel() -> MyGenericVM {
return self.mv_generic_viewModel as! MyGenericVM
}
}

extension MyVM:mv_viewModel{
func mv_model() -> Any {
return self.mv_generic_model as Any
}
func mv_router() -> MyRT {
return self.mv_generic_router as! MyRT
}
func mv_view() -> MyVC {
return self.mv_generic_view as! MyVC
}
}


extension MyVC:MyGenericVC{
func reloadTableView() {
print("reload tv")
}
}

extension MyVM:MyGenericVM{
func tableReloaded() {
print("asked to realod")
}
}



var router = MyRT()
var vm = MyVM()
var vc = MyVC()
router.movver_VC_Bind(model: nil, viewModel: &vm, viewController: &vc, previousRouter: nil)
vc.mv_viewModel().tableReloaded()
*/
