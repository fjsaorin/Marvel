//
//  FetchCharacterInteractor.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import Foundation

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
