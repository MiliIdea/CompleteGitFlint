//
//  ChatHistoryModel.swift
//  HojreYar
//
//  Created by Soheil on 11/23/17.
//  Copyright © 2017 Soheil. All rights reserved.
//

import UIKit
import ObjectMapper


class ChatHistoryModel: NSObject, Mappable {
    
    
    public var status:String?
    public var message:String?
    public var data:[ChatItem]?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        data <- map["data"]
    }
    

}
