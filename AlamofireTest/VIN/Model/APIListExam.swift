//
//  APIListExam.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.
//


import Foundation
import ObjectMapper

class APIListExam: Mappable {
    var exams = [Exams]()

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        exams <- map["exams"]

    }
}
class Exams: Mappable {
    var id: Int?
    var name: String?
    var timeallow: Int?
    var status:Int?
    var questionscount: Int?
    var subjectid:Int?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        timeallow <- map["time_allow"]
        status <- map["status"]
        questionscount <- map["questions_count"]
        subjectid <- map["subject_id"]
    }
}

