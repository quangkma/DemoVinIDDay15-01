//
//  APILogin.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.
//

import Foundation
import ObjectMapper

class APILogin: Mappable {
    var token = ""
    //    var code = 1004
    //    var message = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        token <- map["token"]
        //         code <- map["code"]
        //        message <- map["message"]
        
    }
}
