//
//  AuthPageModulAssembly.swift
//  WatchGitHub
//
//  Created by Alexey Mokrousov on 6/7/23.
//

import UIKit

protocol AuthPageModuleAssemblyProtocol {
    
    static func buildModule() -> UIViewController
    
}

enum AuthPageModuleAssembly: AuthPageModuleAssemblyProtocol {
    
    static func buildModule() -> UIViewController {
        let viewModel = AuthPageViewModel(networkManager: NetworkManager.shared, keyValueStorage: KeyValueStorage.shared)
        let viewController = AuthPageViewController(nibName: "AuthViewController", bundle: nil, viewModel: viewModel)
        viewModel.viewContr = viewController
                
        return viewController
    }
    
}
