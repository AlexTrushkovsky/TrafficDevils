//
//  CardModel.swift
//  TrafficDevils
//
//  Created by Алексей Трушковский on 03.05.2021.
//

import Foundation

struct Card: Hashable {
    var isFaceUp = false
    var isMatched = false
    var flipCount = 0
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return Card.identifierFactory
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
