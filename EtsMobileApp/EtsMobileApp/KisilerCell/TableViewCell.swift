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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dogumTarihiLabel: UILabel!
    @IBOutlet weak var ePostaLabel: UILabel!
    @IBOutlet weak var telefonLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowSet()
        dashedLine()
        
        
        
        
    }
    
    func shadowSet() {
        
        //cell'ler arası shadow ayarlandı
        anaView.layer.cornerRadius = 8
        let myColor = #colorLiteral(red: 0.7450980392, green: 0.6862745098, blue: 0.7960784314, alpha: 1)
        anaView.layer.shadowColor = myColor.cgColor
        anaView.layer.shadowOffset = CGSize(width: 2, height: 2)
        anaView.layer.shadowOpacity = 0.4
        anaView.layer.shadowRadius = 10
        self.backgroundColor = UIColor.clear
    }
    //cell içerisinde bulunan dashLine tanımlanıp konumlandırıldı
    func dashedLine() {
        let width = UIScreen.main.bounds.width
        let rect = CGRect.init(origin: CGPoint.init(x: 21, y: 46), size: CGSize.init(width: width - 90, height: 0))//Set Height width as you want
        let layer = CAShapeLayer.init()
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 0)
        layer.path = path.cgPath;
        layer.strokeColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1).cgColor; // Set Dashed line Color
        layer.lineDashPattern = [3,5]; // Here you set line length
        layer.backgroundColor = UIColor.clear.cgColor;
        layer.fillColor = UIColor.clear.cgColor;
        self.anaView.layer.addSublayer(layer);
    }
    func ayarla(ad: String, dogumTarihi: String, ePosta: String, telefon: String ){
        nameLabel.text = ad
        dogumTarihiLabel.text = dogumTarihi
        ePostaLabel.text = ePosta
        telefonLabel.text = telefon
        
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
