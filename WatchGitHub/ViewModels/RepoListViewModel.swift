//
//  RepoListViewModel.swift
//  WatchGitHub
//
//  Created by Andrei on 8/6/23.
//

import Foundation

struct RepoListViewModel {
    
    var repos: [Repo]?
    var numberOfSection: Int? { return 1 }
    var numberOfRowsInSecrion: Int? { return self.repos?.count }
    
    func repoAtIndex(_ index: Int) -> RepoViewModel? {
        let repo = self.repos?[index]
        return RepoViewModel(repo!)
    }
    
    func repoDetailsAtIndex(_ index: Int) -> RepoDetailsViewModel? {
        guard let repo = self.repos?[index] else { return nil }
        
        return RepoDetailsViewModel(repo)
            
    }
    
    mutating func fetchRepositories() {
        
        var array: [Repo] = []
        NetworkManager.shared.getRepositories { result in
            switch result {
            case .success(let data):
               array = data
            case .failure(let error):
                print(error)
            }
        }
        repos = array
    }
}

struct RepoViewModel {
    
    private let repo: Repo
    
    init(_ repo: Repo) { self.repo = repo }
    
    var name: String { return self.repo.name }
    var description: String { return self.repo.description ?? "no info" }
    var language: String { return self.repo.language ?? "no info" }
}


    


