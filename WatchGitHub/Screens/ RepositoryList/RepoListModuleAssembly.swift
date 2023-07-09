//
//  RepoListModuleAssembly.swift
//  WatchGitHub
//
//  Created by Alexey Mokrousov on 9/7/23.
//

import UIKit

protocol RepoListModuleAssemblyProtocol {
    
    static func buildModule() -> UIViewController
    
}

enum RepoListModuleAssembly: RepoListModuleAssemblyProtocol {
    
    static func buildModule() -> UIViewController {
        var viewModel = RepoListViewModel(networkManager: NetworkManager.shared)
        let viewController = RepoListViewController(nibName: "RepositoryListViewController", bundle: nil, viewModel: viewModel)
        viewModel.viewContr = viewController
                
        return viewController
    }
    
}
