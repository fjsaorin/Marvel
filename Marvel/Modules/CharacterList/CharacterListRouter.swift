//
//  CharacterListRouter.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import Foundation

final class CharacterListRouter: Router {
    
    func navigateToDetail(characterId: Int) {
        let detailView = modulesFactory.characterDetailBuilder.build(characterId: characterId)
        viewController?.navigationController?.pushViewController(detailView, animated: true)
    }
}
