//
//  InternetManager.swift
//  Gymondo
//
//  Created by Mostafa El-Sayed on 16/12/2021.
//

import Foundation

class InternetManager {
    
    static let shared = InternetManager()
    
    private var reachability = try? Reachability()
    private var isReachable: Bool?
    
    private init() {
        reachability?.whenReachable = {[weak self ] _ in
            self?.isReachable = true
        }
        
        reachability?.whenUnreachable = {[weak self ] _ in
            self?.isReachable = false
        }
        try? reachability?.startNotifier()
    }
    
    func isInternetConnectionAvailable() -> Bool {
        return isReachable ?? (reachability?.connection != .unavailable)
    }
}
