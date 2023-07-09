//
//  RepoListViewModel.swift
//  WatchGitHub
//
//  Created by Andrei on 8/6/23.
//

import Foundation

protocol RepoListViewModelProtocol {
    
    var repos: [Repo]? { get set }
    var numberOfRowsInSection: Int? { get }
    
    func repoAtIndex(_ index: Int) -> RepoViewModel?
    func repoDetailsAtIndex(_ index: Int) -> Repo?
    func fetchRepositories()
    
}

class RepoListViewModel: RepoListViewModelProtocol {

    weak var viewContr: RepoListViewProtocol?
    
    var repos: [Repo]?
    var numberOfSection: Int? { return 1 }
    var numberOfRowsInSection: Int? { return self.repos?.count }
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        fetchRepositories()
    }
    
    func repoAtIndex(_ index: Int) -> RepoViewModel? {
        let repo = self.repos?[index]
        return RepoViewModel(repo!)
        
    }
    
    func repoDetailsAtIndex(_ index: Int) -> Repo? {
        guard let repo = self.repos?[index] else { return nil }
        
        return repo
            
    }
    
    func fetchRepositories() {
        
        networkManager.getRepositories { result in
            switch result {
            case .success(let data):
                self.repos = data
                self.viewContr?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

struct RepoViewModel {
    
    private let repo: Repo
    
    init(_ repo: Repo) { self.repo = repo }
    
    var name: String { return self.repo.name }
    var description: String { return self.repo.description ?? "no info" }
    var language: String { return self.repo.language ?? "no info" }
}


    


