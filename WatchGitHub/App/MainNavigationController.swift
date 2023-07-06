//
//  MainNavigationController.swift
//  WatchGitHub
//
//  Created by Alexey Mokrousov on 6/7/23.
//

import Foundation
import UIKit

final class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

private extension MainNavigationController {
    
    func setup() {
        
        let authPageController = AuthPageModuleAssembly.buildModule()
        viewControllers = [authPageController]
    }
    
}
