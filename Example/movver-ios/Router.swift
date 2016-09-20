//
//  Router.swift
//  movver-ios
//
//  Created by Pablo Romeu on 15/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import movver_ios

class Router: MOVVER_RT{
    
    var unwrappedController:ViewController{
        return self.currentController as! ViewController
    }
    
    
    
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
                self.viewModel?.movver_RT_Call(event: RouterToViewModelEvents.didShowAlert)
            })
        case .goToCollectionView:
            print("Go to collection")
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
    }
}

class subRouter: Router {
    
}
