//
//  CharacterInteractorFactory.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import Foundation

protocol CharacterInteractorFactoryProtocol {
    func fetchCharactersInteractor(offset: Int, completion: @escaping (Result<[Character], CharacterError>) -> Void) -> Interactor
    func fetchCharacterInteractor(characterId: Int, completion: @escaping (Result<Character, CharacterError>) -> Void) -> Interactor
}

final class CharacterInteractorFactory {
    
    private let repository: CharacterRepositoryProtocol
    
    required init(repository: CharacterRepositoryProtocol) {
        self.repository = repository
    }
}

extension CharacterInteractorFactory: CharacterInteractorFactoryProtocol {
    
    func fetchCharactersInteractor(offset: Int, completion: @escaping (Result<[Character], CharacterError>) -> Void) -> Interactor {
        return FetchCharactersInteractor(offset: offset, repository: repository, completion: completion)
    }
    
    func fetchCharacterInteractor(characterId: Int, completion: @escaping (Result<Character, CharacterError>) -> Void) -> Interactor {
        return FetchCharacterInteractor(characterId: characterId, repository: repository, completion: completion)
    }
}

final class FetchCharactersInteractor: Interactor {
    
    private let offset: Int
    private let repository: CharacterRepositoryProtocol
    private let completion: (Result<[Character], CharacterError>) -> Void
    
    required init(offset: Int, repository: CharacterRepositoryProtocol, completion: @escaping (Result<[Character], CharacterError>) -> Void) {
        self.offset = offset
        self.repository = repository
        self.completion = completion
    }
    
    func execute() {
        repository.fetchCharacters(offset: offset, completion: completion)
    }
}

final class FetchCharacterInteractor: Interactor {
    
    private let characterId: Int
    private let repository: CharacterRepositoryProtocol
    private let completion: (Result<Character, CharacterError>) -> Void
    
    required init(characterId: Int, repository: CharacterRepositoryProtocol, completion: @escaping (Result<Character, CharacterError>) -> Void) {
        self.characterId = characterId
        self.repository = repository
        self.completion = completion
    }
    
    func execute() {
        repository.fetchCharacter(characterId: characterId, completion: completion)
    }
}
