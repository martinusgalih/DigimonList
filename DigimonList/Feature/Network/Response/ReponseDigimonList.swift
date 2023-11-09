//
//  ReponseDigimonList.swift
//  DigimonList
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import Foundation

// MARK: - WelcomeElement
struct ReponseDigimonList: Decodable {
    var name: String
    var img: String
    var level: String

    init(name: String, img: String, level: String) {
        self.name = name
        self.img = img
        self.level = level
    }
}
