//
//  PostViewModel.swift
//  Travel Diaries
//
//  Created by Kailash on 08/05/24.
//

import Foundation
import Combine
import SwiftUI
import SwiftData

@MainActor
class PostViewModel: ObservableObject {
    private let apiManager = APIManager()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var searchResponse: SearchResponse? = nil
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var selectedLocation: String = ""
    @Published var selectedHashtag: String = ""
    
    func fetchLocation(for query: String) {
        self.isSearching = true
        apiManager.fetchLocation(for: query)
            .sink(receiveCompletion: {[weak self] completion in
                switch completion {
                case .finished:
                    print("Request completed successfully")
                    self?.isSearching = false
                case .failure(let errors):
                    self?.searchResponse = .error(errors)
                    self?.isSearching = false
                    print("Error: \(errors)")
                }
            }, receiveValue: { [weak self] response in
                self?.searchResponse = .success(response)
            })
            .store(in: &cancellables)
    }
}


enum SearchResponse {
    case success(LocationResponse)
    case error(APIError)
}

