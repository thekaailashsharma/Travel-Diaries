//
//  User.swift
//  Travel Diaries
//
//  Created by Kailash on 01/05/24.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    let phoneNumber: String
    let userName: String
    let name: String
    let profilePictureUrl: String?
    let gender: Gender
    var travelPreferences: [TravelPreference] = []
    var travelPhotos: [String] = []
    var travelQuestions: [TravelQuestions] = []
}

enum Gender: String, Codable {
    case male = "Male"
    case female = "Female"
    case other = "Other"
}
struct TravelQuestions: Codable {
    enum AboutMeSection: String, CaseIterable {
        case winMeOver = "The way to win me over is"
        case typicalSunday = "Typical Sunday"
        case favoriteFood = "Favorite Food"
        case dreamDestination = "Dream Destination"
        case travelStyle = "Travel Style"
    }
    
    enum StoryTimeSection: String, CaseIterable {
        case mostMemorableTrip = "Most Memorable Trip"
        case travelMishap = "Worst Travel Mishap"
        case unexpectedAdventure = "Unexpected Adventure"
        case localEncounter = "Memorable Local Encounter"
        case lessonLearned = "Biggest Lesson Learned"
    }
    
    enum BucketListSection: String, CaseIterable {
        case topDestination = "Top Bucket List Destination"
        case ultimateAdventure = "Ultimate Adventure Goal"
        case dreamActivity = "Dream Activity"
        case onceInALifetime = "Once in a Lifetime Experience"
        case upcomingTrip = "Upcoming Trip"
    }
    
    enum FavoritesSection: String, CaseIterable {
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




enum TravelPreference: String, CaseIterable, Codable {
    case beaches = "Beaches"
    case mountains = "Mountains"
    case cityLife = "City Life"
    case countryside = "Countryside"
    case adventureSports = "Adventure Sports"
    case historicalSites = "Historical Sites"
    case wildlifeSafari = "Wildlife Safari"
    case hiking = "Hiking"
    case camping = "Camping"
    case roadTrips = "Road Trips"
    case culturalExperiences = "Cultural Experiences"
    case foodExploration = "Food Exploration"
    case islandHopping = "Island Hopping"
    case skiingSnowboarding = "Skiing/Snowboarding"
    case spaRetreats = "Spa Retreats"
    case tropicalGetaways = "Tropical Getaways"
    case wineTasting = "Wine Tasting"
    case architectureTourism = "Architecture Tourism"
    case photographyExcursions = "Photography Excursions"
    case artGalleries = "Art Galleries"
    case musicFestivals = "Music Festivals"
    case scubaDiving = "Scuba Diving"
    case snorkeling = "Snorkeling"
    case kayakingCanoeing = "Kayaking/Canoeing"
    case hotAirBallooning = "Hot Air Ballooning"
    case horsebackRiding = "Horseback Riding"
    case yogaRetreats = "Yoga Retreats"
    case spiritualJourneys = "Spiritual Journeys"
    case luxuryTravel = "Luxury Travel"
}

