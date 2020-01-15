//
//  UITableView.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.
//

import  UIKit

extension UITableView {
func register(cell: [String]) {
    cell.forEach {
        self.register(UINib(nibName: $0, bundle: nil), forCellReuseIdentifier: $0)
    }
}
    

}
