//
//  CharacterService.swift
//  Marvel
//
//  Created by Francisco Javier Saorín on 18/02/2020.
//  Copyright © 2020 Francisco Javier Saorín. All rights reserved.
//

import Foundation

final class CharacterService {
    
    private let baseURL = "https://gateway.marvel.com/v1/public/characters"
    private let publicKey = "92060b4381e1bd8613e4af631b4d0cb7"
    private let privateKey = "0bdf47ceef7f029d94fbc2cb431cf0f3900c63b3"
    
    var queryItems: [URLQueryItem] {
        let timestamp = String(Date().timeIntervalSince1970)
        return [URLQueryItem(name: "apikey", value: publicKey),
                URLQueryItem(name: "hash", value: (timestamp+privateKey+publicKey).md5),
                URLQueryItem(name: "ts", value: timestamp)]
    }

    func getCharacters(offset: Int, completion: @escaping (Result<[Character], CharacterError>) -> Void) {
                
        var queryItems = self.queryItems
        queryItems.append(URLQueryItem(name: "offset", value: String(offset)))
        
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, let response = try? JSONDecoder().decode(Response.self, from: data) else {
                    completion(.failure(.unknown))
                    return
                }
                completion(.success(response.data.results))
            }
        }
        
        task.resume()
    }
    
    func getCharacter(characterId: Int, completion: @escaping (Result<Character, CharacterError>) -> Void) {
        
        let queryItems = self.queryItems
        
        var urlComponents = URLComponents(string: "\(baseURL)/\(characterId)")
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, let response = try? JSONDecoder().decode(Response.self, from: data), response.data.results.count > 0 else {
                    completion(.failure(.unknown))
                    return
                }
                completion(.success(response.data.results.first!))
            }
        }
        
        task.resume()
    }
}
