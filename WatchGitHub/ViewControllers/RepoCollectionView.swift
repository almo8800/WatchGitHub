//
//  RepoCollectionView.swift
//  WatchGitHub
//
//  Created by Andrei on 8/6/23.
//

import UIKit

class RepoCollectionView: UICollectionView, UICollectionViewDataSource {
    
    private var repositories: [Repo]!
    var repoListVM: RepoListViewModel!
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        
        backgroundColor = .black
        //delegate = self
        dataSource = self
        register(RepoCollectionViewCell.self, forCellWithReuseIdentifier: "RepoCell")
        translatesAutoresizingMaskIntoConstraints = false
        self.register(UINib(nibName: "RepoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RepoCell")
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.repoListVM == nil ? 0 : self.repoListVM.numberOfRowsInSecrion!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: "RepoCell", for: indexPath) as? RepoCollectionViewCell else {
            fatalError("RepoCell not found")
        }
        
        let repoVM = self.repoListVM.repoAtIndex(indexPath.row)
        cell.titleLabel.text = repoVM?.name
        cell.descriptionLabel.text = repoVM?.description
        cell.languageLabel.text = repoVM?.language
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        let thisRepoViewModel = repoListVM.repoDetailsAtIndex(indexPath.row)
////        let repoDetailsViewController = RepoDetailInfoViewController(repoDetailsViewModel: thisRepoViewModel)
//        
//    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
