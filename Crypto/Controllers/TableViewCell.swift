//
//  TableViewCell.swift
//  Crypto
//
//  Created by Даниэл Лабецкий on 9.10.22.
//

import UIKit

final class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameCryptoLabel: UILabel!
    @IBOutlet weak var courseCryptoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor(red: 37/255, green: 35/255, blue: 51/255, alpha: 1.0)
    }
    
    func setLabel(name: String, course: String) {
        nameCryptoLabel.text = name
        courseCryptoLabel.text = "$" + course
    }
}
