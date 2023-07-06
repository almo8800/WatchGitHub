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
    //var userName: String?
    
    private init() {
        authToken = "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"
    }
    
    //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
}
