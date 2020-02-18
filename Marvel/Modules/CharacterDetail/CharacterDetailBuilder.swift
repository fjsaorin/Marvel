//
//  CharacterDetailBuilder.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import Foundation

final class CharacterDetailBuilder: Builder {
    
    private let characterInteractorFactory: CharacterInteractorFactory

    init(modulesFactory: ModulesFactory, characterInteractorFactory: CharacterInteractorFactory) {
        self.characterInteractorFactory = characterInteractorFactory
        super.init(modulesFactory: modulesFactory)
    }
}

extension CharacterDetailBuilder: CharacterDetailBuilderProtocol {
    
    func build(characterId: Int) -> CharacterDetailView {
        
        let view = CharacterDetailView()
        let router = CharacterDetailRouter(viewController: view, modulesFactory: modulesFactory)
        let presenter = CharacterDetailPresenter(view: view, router: router, characterInteractorFactory: characterInteractorFactory, characterId: characterId)
        
        view.presenter = presenter
        
        return view
    }
}
