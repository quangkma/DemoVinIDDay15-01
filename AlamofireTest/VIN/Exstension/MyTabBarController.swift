//
//  MyTabBarController.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.
//

import Foundation
import UIKit

class MyTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tab = MyTabBar()
        self.setValue(tab, forKey: "tabBar")
    }
    
}
