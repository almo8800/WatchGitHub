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
    @IBOutlet weak var signInButton: UIButton!
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, viewModel: AuthPageViewModel) {
        self.authPageVM = viewModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
                   
//    init(viewModel: AuthPageViewProtocol, nibName ) {
//        self.authPageVM = viewModel
//        super.init
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // authPageVM.view = self
        
        signInButton.layer.cornerRadius = 5
        
        navigationItem.backButtonTitle = ""
        
        
        tokenTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @IBAction func useMineButtonTappe(_ sender: Any) {
        tokenTextField.text = "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"
        textFieldDidChange(tokenTextField)
    
    }
    @IBAction func signInButton(_ sender: Any) {
        
            saveAuthToken()
            let nextVC = RepositoryListViewController(nibName: "RepositoryListViewController", bundle: nil)
            navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        authPageVM.validateTextfield(authToken: textField.text ?? "wrong token")
    }
    
    func updateTextFieldBorderColor(validate: Bool) {
        
        self.tokenTextField.borderStyle = .roundedRect
        let textFieldLayer = self.tokenTextField.layer
        textFieldLayer.borderWidth = 3
        textFieldLayer.borderColor = validate ? UIColor.green.cgColor : UIColor.red.cgColor
        self.signInButton.isEnabled = validate
        
    }
    
    
 
    
    func saveAuthToken() {
        authPageVM.saveAuthToken(token: tokenTextField.text ?? "")
       
    }

}

