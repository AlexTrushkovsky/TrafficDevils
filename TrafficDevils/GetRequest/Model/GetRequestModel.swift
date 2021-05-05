//
//  GetRequestModel.swift
//  TrafficDevils
//
//  Created by Алексей Трушковский on 04.05.2021.
//

import Foundation

// MARK: - GetRequestModel
struct GetRequestModel: Decodable {
    var places: [Place]?
}

// MARK: - Place
struct Place: Decodable {
    var image: String?
    var city, country: String?
}
