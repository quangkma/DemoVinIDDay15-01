//
//  APIPostAnswers.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.
//

import Foundation
import ObjectMapper

class APIPostAnswers: Mappable {
    var id: Int?
    var spenttime:Int?
    var answeredquestions: [AnsweredQuestions] = []
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        spenttime <- map["spent_time"]
        answeredquestions <- map["answered_questions"]
    }
}

class AnsweredQuestions: Mappable {
    var id: Int?
    var answerid: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        answerid <- map["answer_id"]
    }
}
