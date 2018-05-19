//
//  ForgotPasswordRequestModel.swift
//  Flint
//
//  Created by MILAD on 4/10/18.
//  Copyright © 2018 MILAD. All rights reserved.
//

import Foundation

class ForgotPasswordRequestModel {
    
    init(username : String) {
        
        self.USERNAME = username
        
    }
    
    var USERNAME: String!

    
    func getParams() -> [String: Any]{
        
        return ["username": USERNAME! ]
        
    }
    
}
