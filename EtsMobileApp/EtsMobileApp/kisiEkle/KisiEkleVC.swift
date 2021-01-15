//
//  KisiEkleVC.swift
//  EtsMobileApp
//
//  Created by Salih Erkan Sandal on 15.01.2021.
//

import Foundation
import UIKit

class KisiEkleVC: UIViewController {
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var surNameView: UIView!
    @IBOutlet weak var birthdayDate: UIView!
    @IBOutlet weak var ePostView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kişi Ekle"
        naviBarIconItem()
        self.navigationController!.navigationBar.titleTextAttributes = [.font: UIFont(name: "HelveticaNeue-Light", size: 30)!,
                                                                        .foregroundColor: UIColor.white ]

        self.saveBtn.addGradiant()
        saveBtn.layer.cornerRadius = 25
        noteView.yuvarla()
        nameView.yuvarla()
        surNameView.yuvarla()
        birthdayDate.yuvarla()
        ePostView.yuvarla()
        //yuvarla isminde fonsiyonu extention olarak oluşturdum. UIView+Extentions sınıfında tanımladım
    }
    func naviBarIconItem() {
        //navigation bar'da bulunan "ekle" butonuna image atandı. NavigationBar'a buton eklendi, butonun özellikleri eklendi
        var image = UIImage(named: "backBtn")!
        image = image.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addTapped))
    }
    @objc func addTapped() {
        print("Ok")
        navigationController?.popViewController(animated: true)
        
    }

    
}
extension KisiEkleVC: StoryboardInstantiate {
    static var storyboardType: StoryboardType { return .kisiEkle }
}



