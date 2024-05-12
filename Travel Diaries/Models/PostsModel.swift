//
//  PostsModel.swift
//  Travel Diaries
//
//  Created by Kailash on 11/05/24.
//

import Foundation

import Foundation

struct PostsModel: Identifiable, Codable {
    var id: UUID = .init()
    var user: UserInfo
    var timeStamp: Date
    let title: String
    let description: String
    let location: Location
    var likes: Int = 0
    var comments: [Comment] = []
    var imageUrl: String?
    var impressions: Int = 0
    
}

struct Location: Codable {
    let address: String
    let coordinate: Coordinate?
}

struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
}

struct Comment: Identifiable, Codable {
    let id: String
    let userId: String
    let userName: String
    let timestamp: Date
    let content: String
    var replies: [Comment]
}

struct DiaryModel: Identifiable, Codable {
    var id: UUID = .init()
    let time: Date
    let post: PostsModel
}

