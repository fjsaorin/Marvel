//
//  Router.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import UIKit

class Router {
    
    weak var viewController: UIViewController?
    let modulesFactory: ModulesFactory
    
    required init(viewController: UIViewController, modulesFactory: ModulesFactory) {
        self.viewController = viewController
        self.modulesFactory = modulesFactory
    }
}
