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
    var datePicker :UIDatePicker!
    @IBOutlet weak var txtDatePicker: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    var textField : UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var noteField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kişi Ekle"
        naviBarIconItem()
        self.navigationController!.navigationBar.titleTextAttributes = [.font: UIFont(name: "HelveticaNeue-Light", size: 30)!,
        
                                                                        .foregroundColor: UIColor.white ]
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        textField = noteField
        scrollView.delegate = self
        datePickers()
        noteView.yuvarla()
        nameView.yuvarla()
        surNameView.yuvarla()
        birthdayDate.yuvarla()
        ePostView.yuvarla()
        phoneView.yuvarla()
        
        //yuvarla isminde fonsiyonu extention olarak oluşturdum. UIView+Extentions sınıfında tanımladım
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.saveBtn.addGradiant()
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
    func datePickers() {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        txtDatePicker.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
    }
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        txtDatePicker.text = dateFormatter.string(from: sender.date)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (userInfo.object(forKey: UIResponder.keyboardFrameBeginUserInfoKey)! as AnyObject).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets

        var viewRect = view.frame
        viewRect.size.height -= keyboardSize.height
        if viewRect.contains(textField.frame.origin) {
            let scrollPoint = CGPoint(x: 0, y: textField.frame.origin.y - keyboardSize.height)
            
            scrollView.setContentOffset(scrollPoint, animated: true)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        
        scrollView.endEditing(true)
    }
    
    
}
extension KisiEkleVC: StoryboardInstantiate {
    static var storyboardType: StoryboardType { return .kisiEkle }
}

//scrollView sağ-Sol hareketi yapması kapatıldı. Sadece Dikey haraket edebiliyor
extension KisiEkleVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
}



