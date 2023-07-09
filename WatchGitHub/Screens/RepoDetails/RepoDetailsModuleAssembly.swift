//
//  RepoDetailsModuleAssembly.swift
//  WatchGitHub
//
//  Created by Alexey Mokrousov on 9/7/23.
//

import UIKit


protocol RepoDetailsModuleAssemblyProtocol {
    static func buildModule(repo: Repo) -> UIViewController
    
}

enum RepoDetailsModuleAssembly: RepoDetailsModuleAssemblyProtocol {
    static func buildModule(repo: Repo) -> UIViewController {
        let viewModel = RepoDetailsViewModel(repo, networkManager: NetworkManager.shared)
        let viewController = RepoDetailsViewController(nibName: "RepoInfoViewController", bundle: nil, viewModel: viewModel)
        viewModel.viewContr = viewController
                
        return viewController
    }

}
