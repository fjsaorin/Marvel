//
//  CharacterDetailProtocol.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import Foundation

protocol CharacterDetailViewProtocol: class {
    func display(image: String)
    func display(name: String)
    func display(description: String)
    func display(comics: String)
}

protocol CharacterDetailPresenterProtocol {
    func viewReady()
}

protocol CharacterDetailBuilderProtocol {
    func build(characterId: Int) -> CharacterDetailView
}
