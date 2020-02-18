//
//  CharacterListBuilder.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import Foundation

final class CharacterListBuilder: Builder {
    
    private let characterInteractorFactory: CharacterInteractorFactoryProtocol

    init(modulesFactory: ModulesFactory, characterInteractorFactory: CharacterInteractorFactoryProtocol) {
        self.characterInteractorFactory = characterInteractorFactory
        super.init(modulesFactory: modulesFactory)
    }
}

extension CharacterListBuilder: CharacterListBuilderProtocol {
    
    func build() -> CharacterListView {
        
        let view = CharacterListView()
        let router = CharacterListRouter(viewController: view, modulesFactory: modulesFactory)
        let presenter = CharacterListPresenter(view: view, router: router, characterInteractorFactory: characterInteractorFactory)
        
        view.presenter = presenter
        
        return view
    }
}
