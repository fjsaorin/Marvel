//
//  CharacterListProtocol.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import Foundation

protocol CharacterListViewProtocol: class {
    func display(title: String)
    func reload()
}

protocol CharacterListPresenterProtocol {
    var numberOfRows: Int { get }
    func viewReady()
    func scrolledToBottom()
    func configure(cell: CharacterListCellProtocol, at index: Int)
    func cellTapped(at index: Int)
}

protocol CharacterListRouterProtocol {
    func navigateToDetail(characterId: Int)
}

protocol CharacterListBuilderProtocol {
    func build() -> CharacterListView
}
