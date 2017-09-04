//
//  MOVVERDatasources.swift
//
//  Created by Pablo Romeu on 6/7/16.
//  Copyright © 2016 Pablo Romeu. All rights reserved.
//

import Foundation



// MARK: Datasource protocols

/*
 These protocols accomplish the model and viewController protocols
 */

public protocol MOVVER_VM_Datasource_Protocol:mv_vm {
     var movver_delegateViewModel:   mv_vm! { get set }
     var movver_delegateView:        mv_vc! { get set }
    init(model:Any?, delegateViewModel: mv_vm, router:mv_rt)
    func movver_identifier() -> String
}

public protocol MOVVER_VM_DatasourcePreload_Protocol:MOVVER_VM_Datasource_Protocol {
    func movver_preload()
    func movver_cancelPreloading()
}


public protocol MOVVER_Cell_Datasource_Protocol:mv_vc {
    func movver_bind(viewModel:MOVVER_VM_Datasource_Protocol)
}


