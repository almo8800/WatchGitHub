//
//  Dynamic.swift
//  WatchGitHub
//
//  Created by Andrei on 7/6/23.
//

//import Foundation
//
//class Dynamic<T> {
//    
// 
//    
//   
//    
//    var value: T? {
//        didSet {
//            DispatchQueue.main.async {
//                self.listener?(Self.value)
//            }
//        }
//    }
//    
//    init(_ value: T) {
//        self.value = value
//    }
//    
//    private var listener: ((T) -> Void)?
//    
//    func bind(_ listener: @escaping ((T?) -> Void))  {
//        self.listener = listener
//    }
//}
