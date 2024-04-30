//
//  GetGenericFirebaseee.swift
//  Travel Diaries
//
//  Created by Kailash on 01/05/24.
//

import Foundation
import FirebaseFirestore
import Combine

func getAllData<T>(collection: CollectionReference) -> AnyPublisher<[T], Error> where T: Decodable {
    
    let publisher = PassthroughSubject<[T], Error>()
    
    collection.addSnapshotListener { querySnapshot, error in
        guard let document = querySnapshot?.documents else {
            print("No usernames yet")
            return
        }
        let usernames: [T] = document.compactMap { try? $0.data(as: T.self) }
        publisher.send(usernames)
    }
    
    return publisher.eraseToAnyPublisher()
}
