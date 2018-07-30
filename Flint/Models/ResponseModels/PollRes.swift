//
//  PollRes.swift
//  Flint
//
//  Created by MehrYasan on 6/20/18.
//  Copyright © 2018 MILAD. All rights reserved.
//

import Foundation

struct PollRes : Codable {

    let created_at : CLongLong?
    let answer : CLong?
    let name : String?
    let user : CLong?
    
    enum CodingKeys: String, CodingKey {
        
        case created_at = "created_at"
        case answer = "answer"
        case name = "name"
        case user = "user"
    
    }
    
}
