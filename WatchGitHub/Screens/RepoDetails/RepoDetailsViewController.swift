//
//  RepoInfoViewController.swift
//  WatchGitHub
//
//  Created by Alexey Mokrousov on 3/7/23.
//

import UIKit

class RepoDetailsViewController: UIViewController, UITextViewDelegate {
    
    var repoDetailsViewModel: RepoDetailsViewModel!
    
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var licenseIndicatorLabel: UILabel!
    @IBOutlet weak var licenseTypeLabel: UILabel!
    @IBOutlet weak var numberOfStarsLabel: UILabel!
    @IBOutlet weak var numberOfForksLabel: UILabel!
    @IBOutlet weak var numberOfWatchersLabel: UILabel!
    @IBOutlet weak var readmeView: UITextView! {
        didSet {
            readmeView.delegate = self
        }
    }
    
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, viewModel: RepoDetailsViewModel) {
        self.repoDetailsViewModel = viewModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationStyle = .fullScreen
        navigationBarSetup()
        configuteLabels()
        fetchReadme(url: repoDetailsViewModel.readmeURL ?? "no readme")
        
    }
    
    func navigationBarSetup() {
     
        // Change the background color of the navigation bar
        var appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray3
        
        let barButtonItemAppearance = UIBarButtonItemAppearance()
        barButtonItemAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        
        appearance.buttonAppearance = barButtonItemAppearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.backBarButtonItem?.tintColor = .black
    
    }
    
    func configuteLabels() {
        linkLabel.text = repoDetailsViewModel.link
        if repoDetailsViewModel.license != nil {
            licenseIndicatorLabel.text = "license"
            licenseIndicatorLabel.textColor = .green
        } else {
            licenseIndicatorLabel.text = "license"
            licenseIndicatorLabel.textColor = .lightGray
        }
        licenseTypeLabel.text = repoDetailsViewModel.licenseTypeName
        if let starsNumber = repoDetailsViewModel.starsNumber {
            numberOfStarsLabel.text = String(starsNumber) + " " + "stars" }
        if let forksNumber = repoDetailsViewModel.forksNumber {
            numberOfForksLabel.text = String(forksNumber) + " " + "forks"
        }
        if let watchersNumber = repoDetailsViewModel.watchersNumber {
            numberOfWatchersLabel.text = String(watchersNumber) + " " + "watchers"
        }
    }
    
    func fetchReadme(url: String) {
        NetworkManager.shared.downloadReadme(readmeDownloadUrl: url) { result in
            print(url)
            switch result {
            case .success(let attributedText):
                self.readmeView.attributedText = attributedText
            case .failure(let error):
                print(error)
            }
        }
    }
}
