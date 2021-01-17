//
//  AnaSayfaVM.swift
//  EtsMobileApp
//
//  Created by Salih Erkan Sandal on 17.01.2021.
//

import Foundation
import UIKit


final class AnaSayfaVM {
    var veriler: [Veri]!
    init(){
        veriCek()
    }
    func veriCek(){
        if let cekilenVeriler = UserDefaults.standard.object(forKey: "Kisiler") as? Data {
            let decoder = JSONDecoder()
            
            if let loadedPerson = try? decoder.decode([Veri].self, from: cekilenVeriler) {
                    
                veriler = loadedPerson
            }else {
                veriler = []
            }
        }else {
            let olustur: [Veri] = []
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(olustur){
                UserDefaults.standard.set(encoded, forKey: "Kisiler")
            }
            
            veriler = olustur
        }
    }
    
   
}
