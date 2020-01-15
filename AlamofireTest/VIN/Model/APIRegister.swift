//
//  APIRegister.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.
//

import Foundation
import ObjectMapper

 class APIRegister: Mappable {
     var code: Int?
     var message: String?

     required convenience init?(map: Map) {
         self.init()
     }
    
     func mapping(map: Map) {
         code <- map["code"]
         message <- map["message"]
     }
 }

