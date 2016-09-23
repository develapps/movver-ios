//
//  ViewModel.swift
//  movver-ios
//
//  Created by Pablo Romeu on 15/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import movver_ios

class ViewModel: MOVVER_VM {
    
    // MARK: ViewController call
    
    override func movver_VC_Call(event: Any) {
        let eventVC:ViewControllerEvents = event as! ViewControllerEvents
        switch eventVC {
        case .pressedAlert:
            self.movver_delegateRouter?.movver_VM_Call(event: ViewModelToRouterEvents.showAlert("Alert Button Pressed"))
        case .pressedCollection:
            self.movver_delegateRouter?.movver_VM_Call(event: ViewModelToRouterEvents.goToCollectionView)
        case .pressedTable:
            self.movver_delegateRouter?.movver_VM_Call(event: ViewModelToRouterEvents.goToTableView)
        }
    }
    
    override func movver_RT_Call(event: Any) {
        let eventRT:RouterToViewModelEvents = event as! RouterToViewModelEvents
        switch eventRT {
        case .didShowAlert:
            self.movver_delegateView?.movver_VM_Call(event: ViewModelToViewControllerEvents.changeButtonTitle("Alerted!"))
        }

    }
}
