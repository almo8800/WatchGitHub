//
//  KeyValueStorage.swift
//  WatchGitHub
//
//  Created by Andrei on 6/6/23.
//

import Foundation

class KeyValueStorage {
    
    static let shared = KeyValueStorage()
    var authToken: String?
    
    private init() {
        authToken = ""
    }
}
