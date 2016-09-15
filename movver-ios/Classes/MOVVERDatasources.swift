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

protocol MOVVER_VM_Datasource_Protocol:MOVVER_VM_Protocol {
    func movver_identifier() -> String
}

protocol MOVVER_VM_DatasourcePreload_Protocol:MOVVER_VM_Datasource_Protocol {
    func movver_preload()
    func movver_cancelPreloading()
}


protocol MOVVER_Cell_Datasource_Protocol:MOVVER_VC_Protocol {
    func movver_bind(viewModel:MOVVER_VM_Datasource_Protocol)
}


