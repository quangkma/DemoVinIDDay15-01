//  AnswerTableViewCell.swift
//  AlamofireTest
//
//  Created by Quang on 1/10/20.
//  Copyright © 2020 Quang. All rights reserved.
import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var answerLabel: UILabel!

    var answer: AswerQuestion? {
        didSet{
            if let answer = answer {
                answerLabel.text = answer.contentAswers
                selectButton.isSelected = answer.isSelected
                
        }
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func tapAction(_ sender: Any) {
        
    }
}
