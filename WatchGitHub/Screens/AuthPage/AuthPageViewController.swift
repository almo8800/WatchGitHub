//
//  ViewController.swift
//  WatchGitHub
//
//  Created by Andrei on 5/6/23.
//

import UIKit

protocol AuthPageViewProtocol: AnyObject {
    func updateTextFieldBorderColor(validate: Bool)
}

class AuthPageViewController: UIViewController, AuthPageViewProtocol {
  
    
    private let authPageVM: AuthPageViewModelProtocol
    @IBOutlet weak var tokenTextField: UITextField!
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, viewModel: AuthPageViewModel) {
        self.authPageVM = viewModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backButtonTitle = ""
    
        tokenTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @IBAction func signInButton(_ sender: Any) {
            saveAuthToken()
        
        let repoListViewController = RepoListModuleAssembly.buildModule()
        navigationController?.pushViewController(repoListViewController, animated: true)
        
//        let nextVC = RepositoryListViewController(nibName: "RepositoryListViewController", bundle: nil, viewModel: <#RepoListViewModel#>)
//            navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        authPageVM.validateTextfield(authToken: textField.text ?? "wrong token")
    }
    
    func updateTextFieldBorderColor(validate: Bool) {
        
        self.tokenTextField.borderStyle = .roundedRect
        let textFieldLayer = self.tokenTextField.layer
        textFieldLayer.borderWidth = 3
        textFieldLayer.borderColor = validate ? UIColor.green.cgColor : UIColor.red.cgColor
    }
    
    func saveAuthToken() {
        authPageVM.saveAuthToken(token: tokenTextField.text ?? "")
       
    }

}

