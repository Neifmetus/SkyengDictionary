//
//  TranslationsViewModel.swift
//  SkyengDictionary
//
//  Created by Екатерина Батеева on 12.04.2021.
//

import UIKit

class TranslationsViewModel {
    var meanings: [Meaning] = []
    var selectedRow: Int?
    
    func getImageFrom(urlString: String) -> UIImage? {
        if let url = URL(string: "https:\(urlString)"), let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
}
