//
//  CharacterRepository.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import Foundation

protocol CharacterRepositoryProtocol {
    func fetchCharacters(offset: Int, completion: @escaping (Result<[Character], CharacterError>) -> Void)
    func fetchCharacter(characterId: Int, completion: @escaping (Result<Character, CharacterError>) -> Void)
}

final class CharacterRepository {
    
    private let characterLocalDataSource: CharacterLocalDataSource
    private let characterNetworkDataSource: CharacterNetworkDataSource

    required init(characterLocalDataSource: CharacterLocalDataSource, characterNetworkDataSource: CharacterNetworkDataSource) {
        self.characterLocalDataSource = characterLocalDataSource
        self.characterNetworkDataSource = characterNetworkDataSource
    }
}

extension CharacterRepository: CharacterRepositoryProtocol {
    
    func fetchCharacters(offset: Int, completion: @escaping (Result<[Character], CharacterError>) -> Void) {
        
        if offset < characterLocalDataSource.characters.count {
            completion(Result.success(self.characterLocalDataSource.characters))
            return
        }
        
        characterNetworkDataSource.fetchCharacters(offset: offset) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(let characters):
                self.characterLocalDataSource.save(characters: characters)
                completion(.success(self.characterLocalDataSource.characters))
            case .failure(_):
                completion(.failure(.unknown))
            }
        }
    }
    
    func fetchCharacter(characterId: Int, completion: @escaping (Result<Character, CharacterError>) -> Void) {
        
        if let character = characterLocalDataSource.characters.filter({$0.id == characterId}).first {
            completion(Result.success(character))
            return
        }
        
        characterNetworkDataSource.fetchCharacter(characterId: characterId, completion: completion)
    }
}
