//
//  LocationSearchHistory.swift
//  Travel Diaries
//
//  Created by Kailash on 09/05/24.
//

import Foundation
import SwiftData

@Model
class LocationSearchHistory: Identifiable {
    @Attribute(.unique) var date: Date
    var latitude: Double
    var longitude: Double
    var address: String
    
    init(date: Date, latitude: Double, longitude: Double, address: String) {
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
    }
}
