//
//  KisiEkleVC.swift
//  EtsMobileApp
//
//  Created by Salih Erkan Sandal on 15.01.2021.
//

import Foundation
import UIKit

class KisiEkleVC: UIViewController, UITextFieldDelegate {
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
    @IBOutlet weak var surNameTxt: UITextField!
    @IBOutlet weak var ePostaTxt: UITextField!
    @IBOutlet weak var telefonTxt: UITextField!
    @IBOutlet weak var noteTxtView: UITextView!
    var viewModel: KisiEkleVM = KisiEkleVM()
    @IBOutlet weak var nameUyariLbl: UILabel!
    @IBOutlet weak var surNameUyariLbl: UILabel!
    @IBOutlet weak var dogumUariLbl: UILabel!
    @IBOutlet weak var ePostaUyariLbl: UILabel!
    @IBOutlet weak var telefonUyariLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kişi Ekle"
        naviBarIconItem()
        self.navigationController!.navigationBar.titleTextAttributes = [.font: UIFont(name: "HelveticaNeue-Light", size: 30)!,
                                                                        
                                                                        .foregroundColor: UIColor.white ]
        nameTxt.delegate = self
        nameTxt.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        surNameTxt.delegate = self
        surNameTxt.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        //textField = telefonTxt
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
        //registerKeyboardNotifications()
    }
    
    //isim Soyisim Text'leri max 20 karakter olarak belirlendi
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 20
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
    @IBAction func saveBtnClick(_ sender: Any) {
       
        
        //let kisi = Veri(ad: ad!, soyad: soyad!, dogumTarihi: dogumTarihi!, ePosta: ePosta!, telefon: telefon!, not: note ?? "")
        //viewModel.veriEkle(cek: kisi)
        kontrolEt()
        
    }
    
    
    func olumsuzAlert(){
        let alert = UIAlertController(title: "Dikkat", message: "Bilgileri Kontrol Ediniz", preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)) { [weak self] in
            alert.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    
    func olumluAlert(){
        
            let alert = UIAlertController(title: "Başarılı", message: "Kişi Kaydedildi", preferredStyle: UIAlertController.Style.alert)
            self.present(alert, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)) { [weak self] in
                alert.dismiss(animated: true, completion: nil)
            }
            
            
        
        
    }
    func kontrolEt(){
        let ad = nameTxt.text
        let soyad = surNameTxt.text
        let ePosta = ePostaTxt.text
        let telefon = telefonTxt.text
        let dogumTarihi = txtDatePicker.text
        let note = noteTxtView.text
        
        let adSonuc = adKontrol()
        let soyadSonuc = soyadKontrol()
        let dogumTarihiSonuc = dogumTarihikontrol()
        let ePostaSonuc = ePostaKontol()
        let telefonSonuc = telefonKontrol()
        
        
        
        if adSonuc && soyadSonuc && dogumTarihiSonuc && ePostaSonuc && telefonSonuc {
            
            let kisi = Veri(ad: ad!, soyad: soyad!, dogumTarihi: dogumTarihi!, ePosta: ePosta!, telefon: telefon!, not: note ?? "")
            viewModel.veriEkle(cek: kisi)
            
            olumluAlert()
            print ("basarılı")
        }else {
            
            olumsuzAlert()
            print("Başarısız")
        }
        
    }
    func adKontrol() -> Bool{
        let isValid = (nameTxt.text ?? "").count > 2
        if isValid{
            nameView.layer.borderWidth = 0
            nameView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            nameUyariLbl.text = ""
        }else {
            nameView.layer.borderWidth = 1
            nameView.layer.borderColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
            nameUyariLbl.text = "Hatalı Ad Girişi"
        }
        return isValid
    }
    
    func soyadKontrol() -> Bool{
        let isValid = (surNameTxt.text ?? "").count > 2
        if isValid{
            surNameView.layer.borderWidth = 0
            surNameView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            surNameUyariLbl.text = ""
        }else {
            surNameView.layer.borderWidth = 1
            surNameView.layer.borderColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
            surNameUyariLbl.text = "Hatalı Soyad Girişi"
        }
        return isValid
    }
    
    func dogumTarihikontrol() -> Bool{
        let isValid = (txtDatePicker.text ?? "").count > 0
        if isValid{
            birthdayDate.layer.borderWidth = 0
            birthdayDate.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            dogumUariLbl.text = ""
        }else {
            birthdayDate.layer.borderColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
            birthdayDate.layer.borderWidth = 1
            dogumUariLbl.text = "Hatalı Giriş Yapıldı"
        }
        return isValid
    }
    
    func ePostaKontol() -> Bool{
        let isValid = (ePostaTxt.text ?? "").isValidEmail()
        if isValid{
            ePostView.layer.borderWidth = 0
            ePostView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            ePostaUyariLbl.text = ""
        }else {
            ePostView.layer.borderWidth = 1
            ePostView.layer.borderColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
            ePostaUyariLbl.text = "E-Posta Adresi Yanlış"
        }
        return isValid
    }
    
    func telefonKontrol() -> Bool{
        let isValid = (telefonTxt.text ?? "").count == 10
        if isValid{
            phoneView.layer.borderWidth = 0
            phoneView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            telefonUyariLbl.text = ""
        }else{
            phoneView.layer.borderWidth = 1
            phoneView.layer.borderColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
            telefonUyariLbl.text = "Hatalı Telefon Örn: 5557778811"
        }
        return isValid
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
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}



