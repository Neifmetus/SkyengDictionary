//
//  SearchServiceProtocol.swift
//  SkyengDictionary
//
//  Created by Екатерина Батеева on 11.04.2021.
//

import Foundation

protocol SearchServiceProtocol {
    
    typealias Handler = (Result<[Translate], TranslateError>) -> Void
    
    /**
     Search list of translations for word

     - Parameters:
        - word: Word to search

     - Returns: list of translations
     */
    func search(word: String, then handler: @escaping Handler)
}
