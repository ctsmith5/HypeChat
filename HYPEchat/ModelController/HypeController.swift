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
            self.hypes.insert(hype, at: 0)
            completion(true)
        }
    }
    
    //Fetch
    func fetchHypes(completion: @escaping (Bool) -> Void){
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: HypeConstants.typeKey, predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: HypeConstants.typeKey, ascending: true)]
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error)
                print("/n------/n")
                print(error.localizedDescription)
                completion(false)
                return
            }
            guard let records = records else {completion(false) ; return}
            let hypes = records.compactMap {(Hype(ckRecord: $0))}
            self.hypes = hypes
            completion(true)
        }
    }
    
    //Subscription
    func subscribeToRemoteNotifications(completion: @escaping (Error?) -> Void){
        
    }
}
