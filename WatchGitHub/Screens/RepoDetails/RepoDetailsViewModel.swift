//
//  RepoDetailsViewModel.swift
//  WatchGitHub
//
//  Created by Andrei on 30/6/23.
//

import Foundation

protocol RepoDetailsViewModelProtocol {
    
}

class RepoDetailsViewModel {
    
    weak var viewContr: RepoDetailsViewController?
    
    var isRepo: Repo?
    let networkManager: NetworkManager!
    
    init(_ repo: Repo, networkManager: NetworkManager) {
        self.isRepo = repo
        self.networkManager = networkManager
        
       
        link = repo.html_url
        license = repo.license
        licenseTypeName = repo.license?.name ?? "no license"
        starsNumber = repo.stargazers_count ?? 0
        forksNumber = repo.forks_count ?? 0
        watchersNumber = repo.watchers_count ?? 0

        fullName = repo.full_name
        
        readmeURL = "https://raw.githubusercontent.com/" + (fullName ?? "") + "/main/README.md"
    }
    
    var link: String?
    var license: License?
    var licenseTypeName: String?
    var starsNumber: Int?
    var forksNumber: Int?
    var watchersNumber: Int?
    
    var fullName: String?

    var readmeURL: String?
    

}
