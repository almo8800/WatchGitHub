//
//  RepositoryListViewController.swift
//  WatchGitHub
//
//  Created by Andrei on 5/6/23.
//

import UIKit

protocol RepoListViewProtocol: AnyObject {
    var collectionView: RepoCollectionView! { get set }
}

class RepoListViewController: UIViewController, UICollectionViewDelegateFlowLayout, RepoListViewProtocol {
    
    private var repoListVM: RepoListViewModelProtocol
    var collectionView: RepoCollectionView!
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, viewModel: RepoListViewModel) {
        self.repoListVM = viewModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray3
        
        collectionView = RepoCollectionView(viewModel: repoListVM as! RepoListViewModel)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let repoAtIndex = repoListVM.repoDetailsAtIndex(indexPath.row) else { return }
        let repoDetailsViewController = RepoDetailsModuleAssembly.buildModule(repo: repoAtIndex)
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

    func setupCollectonView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
    


