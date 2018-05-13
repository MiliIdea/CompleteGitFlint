//
//  ResponseCreateChannel.swift
//  HojreYar
//
//  Created by Soheil on 11/23/17.
//  Copyright © 2017 Soheil. All rights reserved.
//

import UIKit
import ObjectMapper


class ResponseCreateChannel: NSObject, Mappable {
    
    public var status:String?
    public var message:String?
    public var channel:String?
    public var chatId:Int?
    public var data:Int?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        channel <- map["channel"]
        chatId <- map["chatId"]
        data <- map["data"]

    }


}
