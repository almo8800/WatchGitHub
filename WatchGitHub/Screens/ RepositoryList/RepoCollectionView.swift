//
//  RepoCollectionView.swift
//  WatchGitHub
//
//  Created by Andrei on 8/6/23.
//

import UIKit

class RepoCollectionView: UICollectionView, UICollectionViewDataSource {
    
    private var repositories: [Repo]!
    var repoListVM: RepoListViewModelProtocol?
    
    init(viewModel: RepoListViewModel) {
        self.repoListVM = viewModel
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        
        backgroundColor = .black
    
        dataSource = self
        register(RepoCollectionViewCell.self, forCellWithReuseIdentifier: "RepoCell")
        translatesAutoresizingMaskIntoConstraints = false
        self.register(UINib(nibName: "RepoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RepoCell")
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let number = self.repoListVM == nil ? 0 : self.repoListVM?.numberOfRowsInSection else {
            return 0
        }
        
        return number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: "RepoCell", for: indexPath) as? RepoCollectionViewCell else {
            fatalError("RepoCell not found")
        }
        
        let repoVM = self.repoListVM?.repoAtIndex(indexPath.row)
        cell.titleLabel.text = repoVM?.name
        cell.descriptionLabel.text = repoVM?.description
        cell.languageLabel.text = repoVM?.language
        
        return cell
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
