//
//  MyHomeViewController.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.
//

import UIKit

class MyHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = CustomLocalizable.titleHome.loadValue()
    }
    @IBAction func touchListExam(){
        let vclistExam  = ListMonHocViewController(nibName: ListMonHocViewController.nameClass, bundle: nil)
        navigationController?.pushViewController(vclistExam, animated: true)
    }
}
