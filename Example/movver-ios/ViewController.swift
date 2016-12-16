//
//  ViewController.swift
//  movver-ios
//
//  Created by Pablo Romeu on 09/15/2016.
//  Copyright (c) 2016 Pablo Romeu. All rights reserved.
//

import UIKit
import Movver

class ViewController: MOVVER_VC {
    
    // MARK: ViewModel call
    
    override func movver_VM_Call(event: Any) {
        let eventVM = event as! ViewModelToViewControllerEvents
        switch eventVM {
        case .changeButtonTitle(let title):
            self.aButton.setTitle(title, for: .normal)
        }
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "pushedSegue" {
			let router = PushedRouter()
			let vc = segue.destination as! MOVVER_VC
			router.movver_VC_Bind(model: nil, viewModelClass: PushedViewModel.self, viewController: vc , previousRouter: self.movver_delegateViewModel.movver_delegateRouter)
		}
	}
	
    @IBOutlet weak var aButton: UIButton!
    
    // MARK: ViewModel events
    
    @IBAction func didPressCollection(_ sender: AnyObject) {
        self.movver_tellViewModel(event: ViewControllerEvents.pressedCollection)
    }

    @IBAction func didPressTable(_ sender: AnyObject) {
        self.movver_tellViewModel(event: ViewControllerEvents.pressedTable)
    }
    
    @IBAction func didPressAlert(_ sender: AnyObject) {
        self.movver_tellViewModel(event: ViewControllerEvents.pressedAlert)
    }
}

