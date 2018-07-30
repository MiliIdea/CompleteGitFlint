//
//  SeenMessageRequestModel.swift
//  Flint
//
//  Created by MehrYasan on 6/26/18.
//  Copyright © 2018 MILAD. All rights reserved.
//

import Foundation

class SeenMessageRequestModel {
    
    init(chat : Int!) {
        
        self.USERNAME = GlobalFields.USERNAME
        
        self.TOKEN = GlobalFields.TOKEN
        
        self.chat = chat
        
    }
    
    var USERNAME: String!
    
    var TOKEN: String!
    
    var chat : Int!
    
    
    
    func getParams() -> [String: Any]{
        
        return ["username": USERNAME! , "token": TOKEN!, "chat": chat!]
        
    }
    
}
