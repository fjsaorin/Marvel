//
//  CharacterDetailPresenter.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import Foundation

final class CharacterDetailPresenter {

    private weak var view: CharacterDetailViewProtocol?
    private let router: CharacterDetailRouterProtocol
    private let characterInteractorFactory: CharacterInteractorFactoryProtocol
    private let characterId: Int
    
    private var fetchCharacterInteractor: Interactor?
    
    private var character: Character?
    
    required init(view: CharacterDetailViewProtocol, router: CharacterDetailRouterProtocol, characterInteractorFactory: CharacterInteractorFactoryProtocol, characterId: Int) {
        self.view = view
        self.router = router
        self.characterInteractorFactory = characterInteractorFactory
        self.characterId = characterId
    }
    
    private func loadCharacter() {
        fetchCharacterInteractor = characterInteractorFactory.fetchCharacterInteractor(characterId: characterId, completion: { [weak self] (result) in
            switch result {
            case .success(let character):
                self?.character = character
                self?.characterLoaded()
            case .failure(_):
                break
            }
        })
        fetchCharacterInteractor?.execute()
    }
    
    private func characterLoaded() {
        guard let character = character else { return }
        view?.display(image: character.thumbnail.url)
        view?.display(name: character.name)
        view?.display(description: character.description)
        view?.display(comics: character.comics.items.map({$0.name}).joined(separator: "\n"))
    }
}

extension CharacterDetailPresenter: CharacterDetailPresenterProtocol {
    
    func viewReady() {
        loadCharacter()
    }
}
