import Foundation

// MARK: - LocationResponse
struct LocationResponse: Codable, Sendable, Hashable {
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable, Sendable, Hashable {
    let title, id, resultType: String?
    let address: Address?
    let position: Position?
    let access: [Position]?
    let categories: [Category]?
    let scoring: Scoring?
}

// MARK: - Position
struct Position: Codable, Sendable, Hashable {
    let lat, lng: Double?
}

// MARK: - Address
struct Address: Codable, Sendable, Hashable {
    let label, countryCode, countryName, stateCode: String?
    let state, county, city, district: String?
    let subdistrict, street, postalCode: String?
}

// MARK: - Category
struct Category: Codable, Sendable, Hashable {
    let id, name: String?
    let primary: Bool?
}

// MARK: - Scoring
struct Scoring: Codable, Sendable, Hashable {
    let queryScore: Int?
    let fieldScore: FieldScore?
}

// MARK: - FieldScore
struct FieldScore: Codable, Sendable, Hashable {
    let city, placeName: Int?
}
