//
//  ServiceSearch.swift
//  SkyengDictionary
//
//  Created by Екатерина Батеева on 11.04.2021.
//

import Foundation

enum TranslateError: Error {
    case urlError
    case networkFailure(Error)
    case invalidData
}

class ServiceSearch: SearchServiceProtocol {
    
    let baseUrl = "https://dictionary.skyeng.ru/api/public/v1/"
    let method = "words/search"

    var session = URLSession.shared

    func search(word: String,
                   then handler: @escaping Handler) {
        guard let url = URL(string: "\(baseUrl)\(method)?search=\(word)") else {
            handler(.failure(.urlError))
            return
        }
        
        let task = session.dataTask(with: url) { result in
            switch result {
            case .success(let data):
                do {
                    let translate = try JSONDecoder().decode([Translate].self, from: data)
                    handler(.success(translate))
                } catch {
                    handler(.failure(.invalidData))
                }
            case .failure(let error):
                handler(.failure(.networkFailure(error)))
            }
        }

        task.resume()
    }
    
}
