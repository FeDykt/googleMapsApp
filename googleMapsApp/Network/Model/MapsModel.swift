//
//  MapsModel.swift
//  googleMapsApp
//
//  Created by fedot on 10.01.2022.
//

import Foundation

struct MapsModel: Codable {
    let points: [Points]
    let lines: [Line]

    enum CodingKeys: String, CodingKey {
        case points = "Points"
        case lines = "Lines"
    }
}

// MARK: - Point
struct Points: Codable {
    let type: LineType
    let id: String
    let properties: PointProperties
    let geometry: PointGeometry
}

// MARK: - Line
struct Line: Codable {
    let type: LineType
    let properties: LineProperties
    var geometry: LineGeometry
}

// MARK: - LineGeometry
struct LineGeometry: Codable {
    let type: PurpleType
    var coordinates: [[Double]]
}

enum PurpleType: String, Codable {
    case lineString = "LineString"
}

// MARK: - LineProperties
struct LineProperties: Codable {
    let subClasses: SubClasses

    enum CodingKeys: String, CodingKey {
        case subClasses = "SubClasses"
    }
}

enum SubClasses: String, Codable {
    case acDBEntityACDBPolyline = "AcDbEntity:AcDbPolyline"
}

enum LineType: String, Codable {
    case feature = "Feature"
}

// MARK: - PointGeometry
struct PointGeometry: Codable {
    let type: FluffyType
    let coordinates: [Double]
}

enum FluffyType: String, Codable {
    case point = "Point"
}

// MARK: - PointProperties
struct PointProperties: Codable {
    let name, propertiesDescription: String
    let created: Created
    let modified: String
    let color: [Double]
    let visible: Bool
    let latitude, longitude, elevation: Double

    enum CodingKeys: String, CodingKey {
        case name
        case propertiesDescription = "description"
        case created, modified, color, visible, latitude, longitude, elevation
    }
}

enum Created: String, Codable {
    case the20210616T084937 = "2021-06-16T08:49:37"
}
