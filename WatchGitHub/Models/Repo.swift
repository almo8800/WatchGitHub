//
//  Repo.swift
//  WatchGitHub
//
//  Created by Andrei on 7/6/23.
//

import Foundation

import Foundation

// MARK: - WelcomeElement
struct Repo: Codable {
    
    let id: Int
    
    let full_name: String?
    
    let name: String
    let description: String?
    let language: String?
    let license: License?
    
    let html_url: String
    let url: String
    
    let stargazers_count: Int?
    let forks_count: Int?
    let watchers_count: Int?

}

struct License: Codable {
    let key: String
    let name: String
    let spdx_id: String
    let url: String
    let node_id: String
}

struct Owner: Codable {
    let login: String
    
}


