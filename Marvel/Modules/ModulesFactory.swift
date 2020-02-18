//
//  ModulesFactory.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import Foundation

final class ModulesFactory {
    
    private lazy var characterLocalDataSource: CharacterLocalDataSource = CharacterLocalDataSource()
    private lazy var characterNetworkDataSource: CharacterNetworkDataSource = CharacterNetworkDataSource(service: CharacterService())
    private lazy var characterRepository: CharacterRepository = CharacterRepository(characterLocalDataSource: characterLocalDataSource, characterNetworkDataSource: characterNetworkDataSource)
    
    var characterListBuilder: CharacterListBuilder {
        return CharacterListBuilder(modulesFactory: self, characterInteractorFactory: CharacterInteractorFactory(repository: characterRepository))
    }
    
    var characterDetailBuilder: CharacterDetailBuilder {
        return CharacterDetailBuilder(modulesFactory: self, characterInteractorFactory: CharacterInteractorFactory(repository: characterRepository))
    }
}
