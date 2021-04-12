//
//  SearchViewMOdel.swift
//  SkyengDictionary
//
//  Created by Екатерина Батеева on 11.04.2021.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func reloadData()
}

class SearchViewModel {
    
    weak var delegate: SearchViewModelDelegate?
    
    let wordsLimitCount = 20
    let service: SearchServiceProtocol = ServiceSearch()
    
    var searchValue: String = "" {
        didSet {
            getTranslation()
        }
    }
    var words: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.reloadData()
            }
        }
    }
    var translations: [Translate] = [] {
        didSet {
            words = translations.map({ $0.text })
        }
    }
    
    func getTranslation() {
        service.search(word: searchValue) { result in
            switch result {
            case .success(let translate):
                self.translations = translate
            case .failure:
                break
            }
        }
    }
    
    func getMeanings(for translation: String) -> [Meaning] {
        var meanings: [Meaning] = []
        translations.forEach {
            if $0.text == translation {
                meanings = $0.meanings
            }
        }
        return meanings
    }
}

