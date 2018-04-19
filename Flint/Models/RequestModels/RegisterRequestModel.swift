//
//  RegisterRequestModel.swift
//  Flint
//
//  Created by MILAD on 4/10/18.
//  Copyright © 2018 MILAD. All rights reserved.
//

import Foundation

class RegisterRequestModel {
    
    init(userName : String! , password : String! ) {
        
        self.USERNAME = userName
        
        self.PASSWORD = password
        
        self.ID = "some_id"
        
        self.TAG = "male"
        
        self.COUNTRY = "IR"
        
        self.DEVICE = "Apple iOS"
        
        self.OS_VERSION = "11.1.2"
        
    }
    
    var USERNAME: String!
    
    var PASSWORD: String!
    
    var ID : String!
    
    var TAG : String!
    
    var COUNTRY : String!
    
    var DEVICE : String!
    
    var OS_VERSION : String!
    
    
    func getParams() -> [String: Any]{
        
        return ["username": USERNAME , "password": PASSWORD , "id" : ID , "tag" : TAG , "country" : COUNTRY , "device" : DEVICE , "os_version" : OS_VERSION]
        
    }
    
}
