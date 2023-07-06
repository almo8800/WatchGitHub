//
//  RepositoryListViewController.swift
//  WatchGitHub
//
//  Created by Andrei on 5/6/23.
//

import UIKit

class RepositoryListViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    private var repoListVM = RepoListViewModel()
    
    var collectionView: RepoCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRepos()
        
        view.backgroundColor = .systemGray3
        fetchData()
        
        collectionView = RepoCollectionView()
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.collectionViewLayout = CustomFlowLayout()
        setupCollectonView()
        
        navigationItem.title = "repositories"
        self.navigationItem.hidesBackButton = true
        let buttonImage = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        let navigationButton = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: #selector(exitButtonTapped))
        navigationItem.rightBarButtonItem = navigationButton
        navigationItem.rightBarButtonItem?.tintColor = .black

    }
    
    func fetchRepos() {
        repoListVM.fetchRepositories()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let thisRepoViewModel = repoListVM.repoDetailsAtIndex(indexPath.row)
        let repoDetailsViewController = RepoInfoViewController(nibName: "RepoInfoViewController", bundle: nil)
        repoDetailsViewController.repoDetailsViewModel = thisRepoViewModel
        
        self.navigationController?.pushViewController(repoDetailsViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let cellHeight: CGFloat = collectionView.bounds.height
        let label = UILabel()
        label.numberOfLines = 5
        let repoVM = self.repoListVM.repoAtIndex(indexPath.row)
        label.text = repoVM?.description
        let labelSize = label.sizeThatFits(CGSize(width: collectionView.bounds.width, height: cellHeight - 16))
    
        return CGSize(width: collectionView.bounds.width, height: labelSize.height + 50)
    }
    
    
    @objc func exitButtonTapped() {
    }

    func fetchData() {
        NetworkManager.shared.getRepositories { result in
            switch result {
            case .success(let repos):
                DispatchQueue.main.async {
                    self.collectionView.repoListVM = RepoListViewModel(repos: repos)
                    self.repoListVM = RepoListViewModel(repos: repos)
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func setupCollectonView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
}
    


