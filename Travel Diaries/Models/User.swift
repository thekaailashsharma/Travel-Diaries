//
//  User.swift
//  Travel Diaries
//
//  Created by Kailash on 01/05/24.
//

import Foundation

struct UserNames: Codable {
    let userName: String
}

struct UserInfo: Codable, Identifiable, Equatable {
    let id: UUID
    let phoneNumber: String
    let userName: String
    let name: String
    let profilePictureUrl: String?
    let gender: Genders
    var travelPreferences: [String] = []
    var travelQuestions: [MyTravelQuestions] = []
}

struct MyTravelQuestions: Hashable, Codable, Equatable {
    let question: String
    let answer: String
}

enum Genders: String, Codable, Equatable {
    case male = "Male"
    case female = "Female"
    case other = "Other"
}

struct TravelQuestions: Codable, Hashable {
    enum AboutMeSection: String, CaseIterable, Hashable {
        case winMeOver = "The way to win me over is"
        case typicalSunday = "Typical Sunday"
        case favoriteFood = "Favorite Food"
        case dreamDestination = "Dream Destination"
        case travelStyle = "Travel Style"
    }
    
    enum StoryTimeSection: String, CaseIterable, Hashable {
        case mostMemorableTrip = "Most Memorable Trip"
        case travelMishap = "Worst Travel Mishap"
        case unexpectedAdventure = "Unexpected Adventure"
        case localEncounter = "Memorable Local Encounter"
        case lessonLearned = "Biggest Lesson Learned"
    }
    
    enum BucketListSection: String, CaseIterable, Hashable {
        case topDestination = "Top Bucket List Destination"
        case ultimateAdventure = "Ultimate Adventure Goal"
        case dreamActivity = "Dream Activity"
        case onceInALifetime = "Once in a Lifetime Experience"
        case upcomingTrip = "Upcoming Trip"
    }
    
    enum FavoritesSection: String, CaseIterable, Hashable {
        case favoriteDestination = "Favorite Travel Destination"
        case mustHaveItem = "Must-Have Travel Item"
        case travelBook = "Favorite Travel Book"
        case travelQuote = "Favorite Travel Quote"
        case travelMemory = "Favorite Travel Memory"
    }
    
    static func questions(for section: Any) -> [String] {
        switch section {
        case is AboutMeSection.Type:
            return AboutMeSection.allCases.map { $0.rawValue }
        case is StoryTimeSection.Type:
            return StoryTimeSection.allCases.map { $0.rawValue }
        case is BucketListSection.Type:
            return BucketListSection.allCases.map { $0.rawValue }
        case is FavoritesSection.Type:
            return FavoritesSection.allCases.map { $0.rawValue }
        default:
            return []
        }
    }
}

