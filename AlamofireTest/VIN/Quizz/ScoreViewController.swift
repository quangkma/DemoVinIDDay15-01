//
//  ScoreViewController.swift
//  AlamofireTest
//
//  Created by Quang on 1/14/20.
//

import UIKit

class ScoreViewController: UIViewController {

    var scores: APISuscess?
    
    @IBOutlet weak var lbscore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(scores?.score ?? 0)
        lbscore?.text = "Số câu trả lời đúng \( scores?.score ?? 0)"
    }
    
    @IBAction func backHome(){
        let vcHome  = MyHomeViewController(nibName: MyHomeViewController.nameClass, bundle: nil)
        navigationController?.pushViewController(vcHome, animated: true)
    }
}
