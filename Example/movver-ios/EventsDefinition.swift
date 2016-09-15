//
//  EventsDefinition.swift
//  movver-ios
//
//  Created by Pablo Romeu on 15/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

enum ViewControllerEvents {
    case pressedAlert
    case pressedCollection
    case pressedTable
}

enum ViewModelToViewControllerEvents{
    case changeButtonTitle
}

enum ViewModelToRouterEvents {
    case showAlert(String)
    case goToCollectionView
    case goToTableView
}
