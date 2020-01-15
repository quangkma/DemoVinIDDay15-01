//
//  CustomLocalizable.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.
//

import Foundation

enum CustomLocalizable: String {
    
    case titlepropertySearch = "Tìm kiếm"
    case titleBookMyhome = "Trang chủ"
    case titlelistExam = "THI THPTQG"
    case myPage = "Cá nhân"
    case titleHome = "THI VINID"
    case titleListExam = " Danh sách đề thi "
    case titlteListMonhoc = "Danh sách môn thi"
//    case menu = "Menu"
//    case listApp = "ListApp"
//    case titleRegister = "TitleRegister"
//    case titleRules = "TitleRules"
//    case titleNewRegiserStepOne = "TitleNewRegiserStepOne"
//    case titleNewRegisterCompleted = "TitleNewRegisterCompleted"
//    case login = "Login"
//    case next = "Next"
//    case password = "Password"
//    case phoneNumber = "PhoneNumber"
    
    func loadValue() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
}
