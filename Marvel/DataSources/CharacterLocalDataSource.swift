//
//  CharacterLocalDataSource.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import Foundation

protocol CharacterLocalDataSourceProtocol {
    var characters: [Character] { get }
    func save(characters: [Character])
}

final class CharacterLocalDataSource: CharacterLocalDataSourceProtocol {
    
    var characters: [Character] = []
    
    func save(characters: [Character]) {
        self.characters.append(contentsOf: characters)
    }
}
