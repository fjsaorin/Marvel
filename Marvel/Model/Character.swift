//
//  Character.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import Foundation

struct Response: Codable {
    let data: ResponseData
}

struct ResponseData: Codable {
    let results: [Character]
}

struct Character: Codable, Equatable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    let comics: Comics
    
    static func ==(lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}

struct Thumbnail: Codable {
    let path: String
    let `extension`: String
    var url: String {
        return "\(path).\(self.extension)"
    }
}

struct Comics: Codable {
    let available: Int
    let items: [Item]
}

struct Item: Codable {
    let name: String
}

enum CharacterError: Error {
    case unknown
}
