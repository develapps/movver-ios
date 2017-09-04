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
class Router: mv_rt,mv_rt_imp{
	var mv_generic_previousRouter: mv_rt?
	var mv_generic_view: mv_vc!
	var mv_generic_viewModel: mv_vm!
}

//--------------------------------------------------------
// MARK: MOVVER router concrete properties
//--------------------------------------------------------

extension Router: mv_router{
	func mv_view() -> ViewController {
		return self.mv_generic_view as! ViewController
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
	func showAlert(alertString: String)
	func showCollection()
	func showTableView()
}

//--------------------------------------------------------
// MARK: implementation of the protocol
//--------------------------------------------------------

extension Router: RouterProtocol{
	func showAlert(alertString: String){
		let alert = UIAlertController(title: "alert", message: alertString, preferredStyle: .alert);
		let button = UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
			self.mv_view().dismiss(animated: true, completion: {
				
			})
		})
		alert.addAction(button)
		self.mv_view().present(alert, animated: true, completion: {
		})
	}
	func showCollection()
	{
		var newRouter = CollectionRouter()
		var vm = CollectionViewModel()
		var vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
		newRouter.movver_VC_Bind(model: nil, viewModel: &vm, viewController: &vc, previousRouter: self)
		self.mv_view().navigationController?.pushViewController(vc, animated: true)
	}
	func showTableView(){
		var newRouter = TableRouter()
		var vm = TableViewModel()
		var vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
		newRouter.movver_VC_Bind(model: nil, viewModel: &vm, viewController: &vc, previousRouter: self)
		self.mv_view().navigationController?.pushViewController(vc, animated: true)
	}

}


/*

override func movver_VM_Call(event: Any) {
let eventViewModel = event as! ViewModelToRouterEvents
switch eventViewModel {
case .showAlert(let alertString):
print("Alert \(alertString)")

let alert = UIAlertController(title: "alert", message: alertString, preferredStyle: .alert);
let button = UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
self.unwrappedController.dismiss(animated: true, completion: {

})
})
alert.addAction(button)
self.unwrappedController.present(alert, animated: true, completion: {
self.movver_tellViewModel(event: RouterToViewModelEvents.didShowAlert)
})
case .goToCollectionView:
print("Go to collection")
let newRouter = CollectionRouter()
self.unwrappedController.navigationController?.pushViewController(newRouter.movver_VC_Instantiate(model: nil,
viewModelClass:CollectionViewModel.self,
storyboard: UIStoryboard(name: "Main", bundle: Bundle.main),
identifier: "CollectionViewController",
previousRouter: self),
animated: true)

case .goToTableView:
print("Go to tableView")
let newRouter = TableRouter()
self.unwrappedController.navigationController?.pushViewController(newRouter.movver_VC_Instantiate(model: nil,
viewModelClass:TableViewModel.self,
storyboard: UIStoryboard(name: "Main", bundle: Bundle.main),
identifier: "TableViewController",
previousRouter: self),
animated: true)


}

*/
