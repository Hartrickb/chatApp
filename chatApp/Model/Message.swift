//
//  Message.swift
//  chatApp
//
//  Created by Bennett Hartrick on 11/11/17.
//  Copyright © 2017 Bennett. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {
    
    var fromID: String?
    var text: String?
    var timestamp: NSNumber?
    var toID: String?
    
    var imageUrl: String?
    
    var imageHeight: NSNumber?
    var imageWidth: NSNumber?
    
    func chatPartnerID() -> String? {
        return fromID == Auth.auth().currentUser?.uid ? toID : fromID
    }
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        
        fromID = dictionary["fromID"] as? String
        text = dictionary["text"] as? String
        timestamp = dictionary["timestamp"] as? NSNumber
        toID = dictionary["toID"] as? String
        
        imageUrl = dictionary["imageUrl"] as? String
        imageHeight = dictionary["imageHeight"] as? NSNumber
        imageWidth = dictionary["imageWidth"] as? NSNumber
        
    }
    
}











