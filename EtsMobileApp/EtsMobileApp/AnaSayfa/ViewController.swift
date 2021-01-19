//
//  ViewController.swift
//  EtsMobileApp
//
//  Created by Salih Erkan Sandal on 14.01.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    
    
    
    var viewModel: AnaSayfaVM = AnaSayfaVM()
    
    
    @IBOutlet weak var searchTextLblView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kişiler"
        self.navigationController!.navigationBar.titleTextAttributes = [.font: UIFont(name: "HelveticaNeue-Light", size: 30)!, .foregroundColor: UIColor.white ]
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.separatorStyle = .none
        naviBarIconItem()
        transparentNaviBar() //Aşağıda oluşturalan navigationBar özellik fonksiyonu çağrıldı
        searchTextLblView.yuvarla()
        
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.veriler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        let verimiz = viewModel.veriler[indexPath.row]
        cell.ayarla(veri: verimiz)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.veriler[indexPath.row].not == "" {
            return 170
            
        }
        return UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let sirasi = indexPath.row
            let count = viewModel.veriler.count - 1
            var yeniDizi: [Veri] = []
            if count >= 0{
                for i in 0...count{
                    if i != sirasi{
                        yeniDizi.append(viewModel.veriler[i])
                        
                    }
                }
            }
            viewModel.kaydet(gelen: yeniDizi)
            tableView.reloadData()
            deleteAlert()
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.veriCek()
        tableView.reloadData()
        
        
    }
    
    
    
    func transparentNaviBar(){
        //Navigation Bar Backgraund Clear color Yapıldı
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func naviBarIconItem() {
        //navigation bar'da bulunan "ekle" butonuna image atandı. NavigationBar'a buton eklendi, butonun özellikleri eklendi
        var image = UIImage(named: "ekleButonu")!
        image = image.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        print("Ok")
        let vc = KisiEkleVC.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func deleteAlert(){
        
        let alert = UIAlertController(title: "Lütfen Bekleyin", message: "Kişi Siliniyor", preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)) { [weak self] in
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
}
extension ViewController: StoryboardInstantiate {
    static var storyboardType: StoryboardType { return .main }
}

