//
//  CharacterListPresenter.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import Foundation

final class CharacterListPresenter {
    
    private weak var view: CharacterListViewProtocol?
    private let router: CharacterListRouterProtocol
    private let characterInteractorFactory: CharacterInteractorFactoryProtocol
    
    private var fetchCharactersInteractor: Interactor?
    
    private var characters: [Character] = []
    private var loadingMore = false
    
    required init(view: CharacterListViewProtocol, router: CharacterListRouterProtocol, characterInteractorFactory: CharacterInteractorFactoryProtocol) {
        self.view = view
        self.router = router
        self.characterInteractorFactory = characterInteractorFactory
    }
    
    private func loadCharacters(offset: Int = 0) {
        print("Loading characters with offset \(offset)")
        fetchCharactersInteractor = characterInteractorFactory.fetchCharactersInteractor(offset: offset, completion: { [weak self] (result) in
            switch result {
            case .success(let characters):
                self?.characters = characters
                self?.view?.reload()
            case .failure(_):
                break
            }
            self?.loadingMore = false
        })
        fetchCharactersInteractor?.execute()
    }
}

extension CharacterListPresenter: CharacterListPresenterProtocol {
    
    var numberOfRows: Int {
        return characters.count
    }
    
    func viewReady() {
        view?.display(title: "Marvel")
        loadCharacters()
    }
    
    func scrolledToBottom() {
        guard !loadingMore else { return }
        loadingMore = true
        loadCharacters(offset: characters.count)
    }
    
    func configure(cell: CharacterListCellProtocol, at index: Int) {
        let character = characters[index]
        cell.display(image: character.thumbnail.url)
        cell.display(name: character.name)
    }
    
    func cellTapped(at index: Int) {
        let character = characters[index]
        router.navigateToDetail(characterId: character.id)
    }
}
