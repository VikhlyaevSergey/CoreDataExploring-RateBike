//
//  GeneralPresenter.swift
//  RateBike
//
//  Created by Сергей Вихляев on 04.05.2020.
//  Copyright (c) 2020 Сергей Вихляев. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol GeneralPresentationLogic: class {
    func presentSomething()
}

protocol GeneralViewControllerOutput {
    func someActionTriggered()
}

class GeneralPresenter: NSObject, GeneralPresentationLogic {
    var interactor: GeneralBusinessLogic!
    weak var viewController: GeneralDisplayLogic!
    var router: GeneralRoutingLogic!
    
    // MARK: Presentation Logic
    
    func presentSomething() {
        viewController.displaySomething()
    }
}

extension GeneralPresenter: GeneralViewControllerOutput {
    func someActionTriggered() {
    }
}

extension GeneralPresenter: UITableViewDelegate {
    
}
