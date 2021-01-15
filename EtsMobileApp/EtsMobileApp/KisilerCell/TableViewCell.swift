//
//  TableViewCell.swift
//  EtsMobileApp
//
//  Created by Salih Erkan Sandal on 16.01.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var anaView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        anaView.layer.cornerRadius = 8
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
