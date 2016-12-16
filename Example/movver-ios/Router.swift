//
//  Router.swift
//  movver-ios
//
//  Created by Pablo Romeu on 15/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Movver

class Router: MOVVER_RT{
    
    var unwrappedController:ViewController{
        return self.movver_currentController as! ViewController
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
    }
}

class subRouter: Router {
    
}
