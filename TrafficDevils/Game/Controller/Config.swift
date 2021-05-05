//
//  Config.swift
//  TrafficDevils
//
//  Created by Алексей Трушковский on 03.05.2021.
//

import UIKit

struct ScoreConfig {
    static let correctMatch = 80 //Score add if correct
    static let wrongMatch = 40 //Score dec if wrong
}

struct CardImages {
    static let images = ["front1", "front2", "front3", "front4", "front5", "front6", "front7", "front8"]
}

struct Shavings {
    static let velocities = [80, 100, 120, 150]
    static let images = [UIImage(named: "shaving1")!, UIImage(named: "shaving2")!, UIImage(named: "shaving3")!, UIImage(named: "shaving4")!]
}
