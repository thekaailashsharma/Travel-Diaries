//
//  APIErrors.swift
//  Travel Diaries
//
//  Created by Kailash on 08/05/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}
