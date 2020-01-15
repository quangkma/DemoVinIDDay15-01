//
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.
//

import Foundation
import ObjectMapper

class APIQuizz: Mappable {
    var id: Int?
    var name: String?
    var timeallow: Int?
    var status: Int?
    var subjectid:Int?
    var questions = [Questions]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        timeallow <- map["time_allow"]
        status <- map["status"]
        subjectid <- map["subjectid"]
        questions <- map["questions"]
    }
}

class Questions: Mappable {
    var idQuestion: Int?
    var contentQuestion: String?
    var questionanswers = [AswerQuestion]()
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        idQuestion <- map["id"]
        contentQuestion <- map["content"]
        questionanswers <- map["question_answers"]
    }
}

class AswerQuestion: Mappable {
    var idAswers: Int?
    var contentAswers: String?
    var isSelected = false
    required convenience init?(map: Map) {
        self.init()
        
    }
    
    func mapping(map: Map) {
        idAswers <- map["id"]
        contentAswers <- map["content"]
    }
}

