//
//  TableViewCell.swift
//  EtsMobileApp
//
//  Created by Salih Erkan Sandal on 16.01.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var anaView: UIView!
    @IBOutlet weak var disView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        anaView.layer.cornerRadius = 8
        let myColor = #colorLiteral(red: 0.7450980392, green: 0.6862745098, blue: 0.7960784314, alpha: 1)
        anaView.layer.shadowColor = myColor.cgColor
        anaView.layer.shadowOffset = CGSize(width: 2, height: 2)
        anaView.layer.shadowOpacity = 0.4
        anaView.layer.shadowRadius = 10
        self.backgroundColor = UIColor.clear
    }

    
    
}
extension TableViewCell {
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
