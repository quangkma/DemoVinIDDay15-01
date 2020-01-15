//
//  APIList.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.
//

import Foundation
import ObjectMapper

class APIList: Mappable {
    var subjects = [Subject]()

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
       subjects <- map["subjects"]
    }
}

class Subject: Mappable {
    var id: Int?
    var name: String?
   required convenience init?(map: Map) {
        self.init()
    }
    
     func mapping(map: Map) {
                 id <- map["id"]
                name <- map["name"]
    }
}
