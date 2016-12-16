//
//  CollectionViewModel.swift
//  movver-ios
//
//  Created by Pablo Romeu on 20/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Movver

class CollectionViewModel: MOVVER_VM{
    lazy var viewModelDatasource:Array<MOVVER_CollectionCellViewModel> =  [
        MovverCollectionCellViewModel(model: "Hello1", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello2", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello3", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello4", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello5", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello1", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello2", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello3", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello4", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello5", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello1", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello2", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello3", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello4", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello5", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello1", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello2", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello3", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello4", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello5", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello1", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello2", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello3", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello4", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello5", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello1", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello2", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello3", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello4", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello5", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello1", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello2", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello3", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello4", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello5", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello1", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello2", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello3", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello4", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello5", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello1", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello2", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello3", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello4", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello5", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello1", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello2", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello3", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello4", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello5", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello1", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello2", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello3", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello4", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello5", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello1", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello2", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello3", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello4", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello5", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello1", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello2", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello3", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello4", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello5", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello1", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello2", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello3", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello4", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello5", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello1", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello2", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello3", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello4", delegateViewModel: self, router: self.movver_delegateRouter),
        MovverCollectionCellViewModel(model: "Hello5", delegateViewModel: self, router: self.movver_delegateRouter),
        ]

}
