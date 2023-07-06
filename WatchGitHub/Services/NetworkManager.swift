//
//  NetworkManager.swift
//  WatchGitHub
//
//  Created by Andrei on 6/6/23.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    var url: String = "https://api.github.com/user/repos"
    var authToken: String?
    
    var headers: HTTPHeaders? {
        var generatedHeaders: HTTPHeaders = [:]
        if let token = authToken {
            generatedHeaders = [
                "Accept": "application/vnd.github+json",
                "Visibility": "private",
                "Authorization": "Bearer \(token)",
                "X-GitHub-Api-Version": "2022-11-28"
            ]
        }
        return generatedHeaders
    }
    
    var headersForReadme: HTTPHeaders? {
        var readmeHedders: HTTPHeaders = [:]
        if let token = authToken {
            readmeHedders = [
                "Accept" : "application/vnd.github+json",
                "Authorization" : "Bearer \(authToken)",
                "X-GitHub-Api-Version" : "2022-11-28"
            ]
        }
        return readmeHedders
    }
    
    init() {
//        self.url = "https://api.github.com/user/repos"
//        self.authToken = KeyValueStorage.shared.authToken!
//        self.headers = [
//            "Accept": "application/vnd.github+json",
//            "Visibility": "private",
//            "Authorization": "Bearer \(authToken)",
//            "X-GitHub-Api-Version": "2022-11-28"
//        ]
//
//        self.headersForReadme = [
//            "Accept" : "application/vnd.github+json",
//            "Authorization" : "Bearer \(authToken)",
//            "X-GitHub-Api-Version" : "2022-11-28"
//        ]
        
    }
    
    func getResponse(authToken: String, completion: @escaping(Result<Int, AFError>) -> Void) {
        
        self.authToken = authToken
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: headers,
                   interceptor: nil)
        .validate()
        .response { response in
            if let statusCode = response.response?.statusCode {
                completion(.success(statusCode))
            } else {
                completion(.failure(.invalidURL(url: self.url)))
            }
        }
    }
            
            
    func getRepositories(completion: @escaping(Result<[Repo], AFError>) -> Void) {
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: headers,
                   interceptor: nil)
        .responseDecodable(of: [Repo].self) { response in
            print(response)
            switch response.result {
            case .success(let data):
                completion(.success(data))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func downloadReadme(readmeDownloadUrl: String, completion: @escaping(Result<NSAttributedString, AFError>) -> Void) {
        
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("readme.md")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        AF.download(readmeDownloadUrl,
//                    method: .get,
//                    parameters: nil,
//                    headers: headersForReadme,
                    to: destination).response { response in
            if response.error == nil, let filePath = response.fileURL?.path {
                print("Readme.md downloaded successfully at \(filePath)")
                let formattedText = self.openReadme()
                completion(.success(formattedText))
            } else {
                print("Error downloading readme.md: \(response.error?.localizedDescription ?? "")")
            }
        }
        
//        AF.download(readmeDownloadUrl, to: destination).response { response in
//            if response.error == nil, let filePath = response.fileURL?.path {
//                print("Readme.md downloaded successfully at \(filePath)")
//                let formattedText = self.openReadme()
//                completion(.success(formattedText))
//            } else {
//                print("Error downloading readme.md: \(response.error?.localizedDescription ?? "")")
//            }
//        }
    }
                           
    func openReadme() -> NSAttributedString {
        
        var formattedText = NSAttributedString()
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("readme.md")
                    
        do {
            let readmeText = try String(contentsOf: fileURL, encoding: .utf8)
            print(readmeText)
            formattedText = formatReadmeText(readmeText: readmeText)
        } catch {
            print("Error reading readme.md file: (error.localizedDescription)")
        }
        
        return formattedText
    }
    
    func formatReadmeText(readmeText: String) -> NSAttributedString {
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.white
        ]

        let attributedString = NSAttributedString(string: readmeText, attributes: attributes)
        
           return attributedString
       }
 
}
                           
enum NetworkError: Error {
   case badUrl, badRequest, badResponse, invalidData
}
