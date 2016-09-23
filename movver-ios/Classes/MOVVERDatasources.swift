//
//  MOVVERDatasources.swift
//  Santoral Pro
//
//  Created by Pablo Romeu on 6/7/16.
//  Copyright © 2016 Pablo Romeu. All rights reserved.
//

import Foundation



// MARK: Datasource protocols

/*
 These protocols accomplish the model and viewController protocols
 */

public protocol MOVVER_VM_Datasource_Protocol:MOVVER_VM_Protocol {
    var movver_delegateViewModel:   MOVVER_VM_Protocol? { get set }
    var movver_delegateView:        MOVVER_VC_Protocol? { get set }
    init(model:Any?, delegateViewModel: MOVVER_VM_Protocol?, router:MOVVER_RT_Protocol?)
    func movver_identifier() -> String
}

public protocol MOVVER_VM_DatasourcePreload_Protocol:MOVVER_VM_Datasource_Protocol {
    func movver_preload()
    func movver_cancelPreloading()
}


public protocol MOVVER_Cell_Datasource_Protocol:MOVVER_VC_Protocol {
    func movver_bind(viewModel:MOVVER_VM_Datasource_Protocol)
}


