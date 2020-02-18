//
//  CharacterInteractorFactory.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import Foundation

final class CharacterInteractorFactory {
    
    private let repository: CharacterRepositoryProtocol
    
    required init(repository: CharacterRepositoryProtocol) {
        self.repository = repository
    }

    func fetchCharactersInteractor(offset: Int, completion: @escaping (Result<[Character], CharacterError>) -> Void) -> Interactor {
        return FetchCharactersInteractor(offset: offset, repository: repository, completion: completion)
    }
    
    func fetchCharacterInteractor(characterId: Int, completion: @escaping (Result<Character, CharacterError>) -> Void) -> Interactor {
        return FetchCharacterInteractor(characterId: characterId, repository: repository, completion: completion)
    }
}
