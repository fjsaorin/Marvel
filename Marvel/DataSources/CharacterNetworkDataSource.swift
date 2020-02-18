//
//  CharacterNetworkDataSource.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import Foundation

protocol CharacterNetworkDataSourceProtocol {
    func fetchCharacters(offset: Int, completion: @escaping (Result<[Character], CharacterError>) -> Void)
    func fetchCharacter(characterId: Int, completion: @escaping (Result<Character, CharacterError>) -> Void)
}

final class CharacterNetworkDataSource {
    
    private let service: CharacterService
    
    required init(service: CharacterService) {
        self.service = service
    }
}

extension CharacterNetworkDataSource: CharacterNetworkDataSourceProtocol {
    
    func fetchCharacters(offset: Int, completion: @escaping (Result<[Character], CharacterError>) -> Void) {
        service.getCharacters(offset: offset, completion: completion)
    }
    func fetchCharacter(characterId: Int, completion: @escaping (Result<Character, CharacterError>) -> Void) {
        service.getCharacter(characterId: characterId, completion: completion)
    }
}
