//
//  FetchCharactersInteractor.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import Foundation

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
