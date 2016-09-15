//
//  TableViewModel.swift
//  movver-ios
//
//  Created by Pablo Romeu on 15/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import movver_ios

class TableViewModel: MOVVER_VM {
    lazy var viewModelDatasource:Array<MovverTableViewModel> =  [
        MovverTableViewModel(model: "Hello", delegate: self.delegateView, router: self.delegateRouter),
        MovverTableViewModel(model: "Hello2", delegate: self.delegateView, router: self.delegateRouter),
        MovverTableViewModel(model: "Hello3", delegate: self.delegateView, router: self.delegateRouter),
        MovverTableViewModel(model: "Hello4", delegate: self.delegateView, router: self.delegateRouter),
        MovverTableViewModel(model: "Hello5", delegate: self.delegateView, router: self.delegateRouter),
        ]
}
