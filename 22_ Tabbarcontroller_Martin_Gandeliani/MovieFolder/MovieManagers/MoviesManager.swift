//
//  MoviesManager.swift
//  19_Networking-2_Martin_Gandeliani
//
//  Created by Martin on 28.11.25.
//

import Foundation

class MoviesManager {
    func getMoviesData(completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "https://www.omdbapi.com/?s=avengers&apikey=4352a844") else { return }
        
        URLSession.shared.dataTask(with: url) { Data, Response, error in
            guard let data = Data else { return }
            guard let urlResponse = Response as? HTTPURLResponse else { return }
            guard urlResponse.statusCode == 200 else { return }
            
            do {
                let movie = try JSONDecoder().decode(SearchResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(movie.search)
                }
            } catch {
                print("decode error:", error)
            }
        }.resume()
    }
}
