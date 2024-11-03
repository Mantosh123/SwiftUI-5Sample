//
//  Prospect.swift
//  HotProspects
//
//  Created by Mantosh Kumar on 03/11/24.
//

import SwiftData

@Model
class Prospect {
    
    var name: String
    var emailAddress: String
    var isConnected: Bool
    
    init(name: String, emailAddress: String, isConnected: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isConnected = isConnected
    }
}
