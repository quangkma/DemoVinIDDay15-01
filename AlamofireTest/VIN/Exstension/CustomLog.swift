//
//  CustomLog.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.
//

import Foundation

struct CustomLog {
    
    static func show(_ format: String, _ args: CVarArg...) {
        NSLog(format, args)
    }
}
