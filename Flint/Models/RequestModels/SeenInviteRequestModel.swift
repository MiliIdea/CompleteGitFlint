//
//  SeenInviteRequestModel.swift
//  Flint
//
//  Created by MehrYasan on 6/26/18.
//  Copyright © 2018 MILAD. All rights reserved.
//

import Foundation

class SeenInviteRequestModel {
    
    init(message : Int! , invite : Int!) {
        
        self.USERNAME = GlobalFields.USERNAME
        
        self.TOKEN = GlobalFields.TOKEN
        
        self.message = message
        
        self.invite = invite
    }
    
    var USERNAME: String!
    
    var TOKEN: String!
    
    var message : Int!
    
    var invite : Int!
    
    
    func getParams() -> [String: Any]{
        
        return ["username": USERNAME! , "token": TOKEN!, "message": message! , "invite" : invite!]
        
    }
    
}
