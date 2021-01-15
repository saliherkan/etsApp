//
//  ViewController.swift
//  EtsMobileApp
//
//  Created by Salih Erkan Sandal on 14.01.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
   
    
    
    
    
    @IBOutlet weak var searchTextLblView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kişiler"
        self.navigationController!.navigationBar.titleTextAttributes = [.font: UIFont(name: "HelveticaNeue-Light", size: 30)!,
                                                                        .foregroundColor: UIColor.white ]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.identifier)
        naviBarIconItem()
        transparentNaviBar() //Aşağıda oluşturalan navigationBar özellik fonksiyonu çağrıldı
        searchTextLblView.yuvarla()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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

}
extension ViewController: StoryboardInstantiate {
    static var storyboardType: StoryboardType { return .main }
}

