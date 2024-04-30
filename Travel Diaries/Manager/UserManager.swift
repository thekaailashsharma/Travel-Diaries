//
//  UserManager.swift
//  Travel Diaries
//
//  Created by Kailash on 01/05/24.
//

import Foundation
import FirebaseFirestore
import Combine

let dummyUsernames = [
    "TravelLover23",
    "AdventureSeeker",
    "WanderlustDreamer",
    "ExploreWithMe",
    "Globetrotter22",
    "SunsetChaser",
    "NomadExplorer",
    "JourneyJunkie",
    "DiscoverEarth",
    "ExploreBeyond",
    "WandererWonderer",
    "RoamingFree",
    "Pathfinder",
    "NatureAdventurer",
    "UrbanExplorer",
    "RoadTripWarrior",
    "BeachBum",
    "MountainManiac",
    "CitySlicker",
    "CulturalConnoisseur",
    "TravelBug",
    "DestinationDreamer",
    "Jetsetter",
    "AdventurousSoul",
    "ExpatLife",
    "BackpackerLife",
    "SafariExplorer",
    "OceanVoyager",
    "SkyHighSeeker",
    "TrailBlazer"
]


final class UserManager {
    
    static let shared = UserManager()
    
    private init() {
        
    }
    
    private let userCollection: CollectionReference = Firestore.firestore().collection("userInfo")
    private let userNamesCollection: CollectionReference = Firestore.firestore().collection("usernames")
    
    private func userDocument(phoneNumber: String) -> DocumentReference {
        userCollection.document(phoneNumber)
    }
    
    private func userNameDocument(userName: String) -> DocumentReference {
        userNamesCollection.document(userName)
    }
    
    
    func updateUser(user: UserInfo) async throws {
        try? userDocument(phoneNumber: user.phoneNumber).setData(from: user)
    }
    
    func updateUserName(username: UserNames) async throws {
        try? userNameDocument(userName: username.userName).setData(from: username)
    }
    
    func addDummyUserNames() async throws {
        for username in dummyUsernames {
            try? await updateUserName(username: UserNames(userName: username))
        }
        
    }
    
    func getAllUsers() -> AnyPublisher<[UserInfo], Error> {
        getAllData(collection: userCollection)
    }
    
    func getAllUsernames() -> AnyPublisher<[UserNames], Error> {
        getAllData(collection: userNamesCollection)
    }
}
