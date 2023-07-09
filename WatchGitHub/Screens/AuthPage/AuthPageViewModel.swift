//
//  AuthPageViewModel.swift
//  WatchGitHub
//
//  Created by Andrei on 7/6/23.
//

import Foundation
import UIKit

protocol AuthPageViewModelProtocol {
    func validateTextfield(authToken: String)
    func saveAuthToken(token: String)
}

class AuthPageViewModel: AuthPageViewModelProtocol {
    
    weak var viewContr: AuthPageViewProtocol?
    let networkManager: NetworkManager
    let keyValueStorage: KeyValueStorage
    
    func validateTextfield(authToken: String) {
        networkManager.getResponse(authToken: authToken) { [weak self] result in
            switch result {
            case .success(let statusCode):
                if statusCode == 200 {
                    self?.viewContr?.updateTextFieldBorderColor(validate: true)
                } else {
                    self?.viewContr?.updateTextFieldBorderColor(validate: false)
                }
            case .failure(let error):
                print(error)
                self?.viewContr?.updateTextFieldBorderColor(validate: false)
            }
        }
    }
    
    func saveAuthToken(token: String) {
        keyValueStorage.authToken = token
    }
    
    init(networkManager: NetworkManager, keyValueStorage: KeyValueStorage) {
        self.networkManager = networkManager
        self.keyValueStorage = keyValueStorage
        
    }
    
}
