//
//  Router.swift
//  movver-ios
//
//  Created by Pablo Romeu on 15/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import movver_ios

class Router: MOVVER_RT<ViewController,ViewModel>{
    override func movver_VM_Call(event: Any) {
        let eventViewModel = event as! ViewModelToRouterEvents
        switch eventViewModel {
        case .showAlert(let alertString):
            print("Alert \(alertString)")
        case .goToCollectionView:
            print("Go to collection")
        case .goToTableView:
            print("Go to tableView")
        }
    }
}
