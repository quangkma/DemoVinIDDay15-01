//
//  ExtenstionViewController.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    public class var nameClass: String {
        return String(describing: self)
    }
    
    static func loadNib<T: NSObject>() -> T? {
        return Bundle.main.loadNibNamed(T.nameClass, owner: nil, options: [:])?.first as? T
    }
}
extension UIViewController {
    
    func addViewController(_ viewController: UIViewController, into view: UIView) {
        self.addChild(viewController)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
}
