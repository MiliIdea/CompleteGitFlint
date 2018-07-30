//
//  GetMessagesRequestModel.swift
//  Flint
//
//  Created by MehrYasan on 6/27/18.
//  Copyright © 2018 MILAD. All rights reserved.
//

import Foundation

class GetMessagesRequestModel {
    
    init(invite : Int , target : Int) {
        
        self.USERNAME = GlobalFields.USERNAME
        
        self.TOKEN = GlobalFields.TOKEN
        
        self.INVITE = invite
        
        self.target = target
        
    }
    
    var USERNAME: String!
    
    var TOKEN: String!
    
    var INVITE : Int!
    
    var target : Int!
    
    
    func getParams() -> [String: Any]{
        
        return ["username": USERNAME! , "token": TOKEN! ,"invite" : INVITE! , "target" : target!]
        
    }
    
}
