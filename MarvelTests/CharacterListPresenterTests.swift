//
//  CharacterListPresenterTests.swift
//  MarvelTests
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import XCTest
@testable import Marvel

class CharacterListPresenterTests: XCTestCase {

    var sut: CharacterListPresenter!
    var view: CharacterListViewMock!
    var router: CharacterListRouterMock!
    var characterInteractorFactory: CharacterInteractorFactoryMock!

    override func setUp() {
        view = CharacterListViewMock()
        router = CharacterListRouterMock()
        characterInteractorFactory = CharacterInteractorFactoryMock()
        sut = CharacterListPresenter(view: view, router: router, characterInteractorFactory: characterInteractorFactory)
    }

    override func tearDown() {
        sut = nil
    }

    // MARK: - Initialization

    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    // MARK: - Functionality
    
    func testTitleIsDisplayedWhenViewIsReady() {
        
        sut.viewReady()
        
        XCTAssertNotNil(view.title)
    }
    
    func testFetchCharactersInteractorIsCalledWhenViewIsReady() {
        
        sut.viewReady()
        
        XCTAssertNotNil(characterInteractorFactory.offset)
    }
    
    func testViewIsReloadedWhenViewIsReady() {
        
        sut.viewReady()
        
        XCTAssertEqual(view.reloadCalled, 1)
    }
    
    func testFetchCharactersInteractorIsCalledWhenUserScrollsDown() {
        
        sut.scrolledToBottom()
        
        XCTAssertNotNil(characterInteractorFactory.offset)
    }
    
    func testCellIsConfigured() {
        
        let cell = CharacterListCellMock()
        
        sut.viewReady()
        sut.configure(cell: cell, at: 0)
        
        XCTAssertNotNil(cell.image)
        XCTAssertNotNil(cell.name)
    }
    
    func textRouterIsCalledWhenCellIsTapped() {
        
        sut.viewReady()
        sut.cellTapped(at: 0)
        
        XCTAssertNotNil(router.characterId)
    }
    
    // MARK: - Mocks

    class CharacterListViewMock: CharacterListViewProtocol {
        
        var title: String?
        var reloadCalled = 0
        
        func display(title: String) {
            self.title = title
        }
        
        func reload() {
            reloadCalled += 1
        }
    }
    
    class CharacterListRouterMock: CharacterListRouterProtocol {
        
        var characterId: Int?
        
        func navigateToDetail(characterId: Int) {
            self.characterId = characterId
        }
    }
    
    class CharacterInteractorFactoryMock: CharacterInteractorFactoryProtocol {
        
        var offset: Int?
        var characterId: Int?
        
        func fetchCharactersInteractor(offset: Int, completion: @escaping (Result<[Character], CharacterError>) -> Void) -> Interactor {
            self.offset = offset
            return FetchCharactersInteractorMock(completion: completion)
        }
        
        func fetchCharacterInteractor(characterId: Int, completion: @escaping (Result<Character, CharacterError>) -> Void) -> Interactor {
            self.characterId = characterId
            return FetchCharacterInteractorMock(completion: completion)
        }
    }
    
    class FetchCharactersInteractorMock: Interactor {
        
        private let characters = [Character(id: 0, name: "", description: "",
                                            thumbnail: Thumbnail(path: "", extension: ""),
                                            comics: Comics(available: 0, items: []))]
        
        private let completion: (Result<[Character], CharacterError>) -> Void
        
        required init(completion: @escaping (Result<[Character], CharacterError>) -> Void) {
            self.completion = completion
        }

        func execute() {
            completion(.success(characters))
        }
    }
    
    class FetchCharacterInteractorMock: Interactor {
        
        private let character = Character(id: 0, name: "", description: "",
                                          thumbnail: Thumbnail(path: "", extension: ""),
                                          comics: Comics(available: 0, items: []))
        
        private let completion: (Result<Character, CharacterError>) -> Void
        
        required init(completion: @escaping (Result<Character, CharacterError>) -> Void) {
            self.completion = completion
        }

        func execute() {
            completion(.success(character))
        }
    }
    
    class CharacterListCellMock: CharacterListCellProtocol {
        
        var image: String?
        var name: String?
        
        func display(image: String) {
            self.image = image
        }
        
        func display(name: String) {
            self.name = name
        }
    }
}
