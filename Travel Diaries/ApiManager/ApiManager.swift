//
//  ApiManager.swift
//  Travel Diaries
//
//  Created by Kailash on 08/05/24.
//

import Foundation
import Combine

class APIManager {
    private let baseURL = "https://geocode.search.hereapi.com/v1/geocode"
    private let apiKey = "OVXwPOfMbCfNnN2Vfv3lWpZnf_MMioswgR650v5gDug"
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchLocation(for query: String) -> AnyPublisher<LocationResponse, APIError> {
        guard let url = URL(string: "\(baseURL)?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)&apiKey=\(apiKey)") else {
            return Fail(error: .invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw APIError.requestFailed(NSError(domain: "", code: 0, userInfo: nil))
                }
                return data
            }
            .decode(type: LocationResponse.self, decoder: JSONDecoder())
            .mapError { error in
                APIError.decodingFailed(error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
