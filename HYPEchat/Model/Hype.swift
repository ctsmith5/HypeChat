//
//  Hype.swift
//  HYPEchat
//
//  Created by Colin Smith on 7/9/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import Foundation
import CloudKit
class Hype {
    var hypeText: String
    var timestamp: Date
    
    init(hypeText: String, timestamp: Date) {
        self.hypeText = hypeText
        self.timestamp = timestamp
    }
}

extension Hype {
    convenience init?(ckRecord: CKRecord) {
        guard let hypeText = ckRecord[HypeConstants.typeKey] as? String,
            let hypeTimestamp = ckRecord[HypeConstants.timestampKey] as? Date else {return nil}
        self.init(hypeText: hypeText, timestamp: hypeTimestamp)
    }
}

extension CKRecord {
    convenience init(hype: Hype){
        self.init(recordType: HypeConstants.typeKey)
        self.setValue(hype.hypeText, forKey: HypeConstants.textKey)
        self.setValue(hype.timestamp, forKey: HypeConstants.timestampKey)
        
        
    }
}

struct HypeConstants {
    static let typeKey = "Hype"
    fileprivate static let textKey = "HypeText"
    fileprivate static let timestampKey = "Timestamp"
}
