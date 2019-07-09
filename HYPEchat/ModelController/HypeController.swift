//
//  HypeController.swift
//  HYPEchat
//
//  Created by Colin Smith on 7/9/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import Foundation
import CloudKit

class HypeController {
    
    let publicDB = CKContainer.default().publicCloudDatabase
    static let shared = HypeController()
    
    var hypes: [Hype] = []
    
    //MARK: - CRUD
    //Save
    func saveHype(text: String, completion: @escaping (Bool) -> Void){
        let hype = Hype(hypeText: text)
        let record = CKRecord(hype: hype)
        publicDB.save(record) { (_, error) in
            if let error = error {
                print(error)
                print("/n------/n")
                print(error.localizedDescription)
                completion(false)
                return
            }
            self.hypes.append(hype)
            completion(true)
        }
    }
    
    //Fetch
    func fetchHypes(completion: @escaping (Bool) -> Void){
        
    }
    
    //Subscription
    func subscribeToRemoteNotifications(completion: @escaping (Error?) -> Void){
        
    }
}
