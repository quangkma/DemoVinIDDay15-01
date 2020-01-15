//
//  APISuscess.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.
//

import Foundation
import ObjectMapper
 class APISuscess: Mappable {
     var score: Int?
     var spenttime: Int?

     required convenience init?(map: Map) {
         self.init()
     }
    
     func mapping(map: Map) {
         score <- map["score"]
         spenttime <- map["spent_time"]
     }
 }
