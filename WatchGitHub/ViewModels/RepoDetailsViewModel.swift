//
//  RepoDetailsViewModel.swift
//  WatchGitHub
//
//  Created by Andrei on 30/6/23.
//

import Foundation

struct RepoDetailsViewModel {
    
   var isRepo: Repo?
    
    init(_ repo: Repo) {
        
        self.isRepo = repo
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
    
    func downloadReadmeFile() {
        print(readmeURL)
        NetworkManager.shared.downloadReadme(readmeDownloadUrl: readmeURL ?? "") { result in
            print(result)
        }
    }

}
