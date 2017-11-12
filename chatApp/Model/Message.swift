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
    
    func chatPartnerID() -> String? {
        return fromID == Auth.auth().currentUser?.uid ? toID : fromID
    }
    
}
