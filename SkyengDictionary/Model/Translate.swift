//
//  Translate.swift
//  SkyengDictionary
//
//  Created by Екатерина Батеева on 11.04.2021.
//

import Foundation

struct Translate: Decodable {
    let id: Int
    let text: String
    let meanings: [Meaning]
}

struct Meaning: Decodable {
    let id: Int
    let partOfSpeechCode: String?
    let translation: Translation
    let previewUrl: String?
    let imageUrl: String?
    let transcription: String?
    let soundUrl: String?
}

struct Translation: Decodable {
    let text: String
    let note: String?
}
