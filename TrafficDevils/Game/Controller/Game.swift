//
//  Game.swift
//  TrafficDevils
//
//  Created by Алексей Трушковский on 03.05.2021.
//

import Foundation

enum Match: Int {
    case no = -1
    case unknown = 0
    case yes = 1
}

struct Game {
    private(set) var cards = [Card]()
    private(set) var score: Int
    private(set) var flipCount: Int
    private(set) var gameOver: Bool
    
    private(set) var correctMatch = Match.unknown
    
    private(set) var highScore: Int {
        get {
            return UserDefaults.standard.integer(forKey: "highscore")
        }
        set {
            if newValue > UserDefaults.standard.integer(forKey: "highscore") {
                UserDefaults.standard.set(newValue, forKey: "highscore")
            }
        }
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        if (!cards[index].isFaceUp) {
            flipCount += 1
            correctMatch = .unknown
        }
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += ScoreConfig.correctMatch
                    correctMatch = Match.yes
                } else if cards[index].flipCount > 0 || cards[matchIndex].flipCount > 0 {
                    score -= ScoreConfig.wrongMatch
                    correctMatch = Match.no
                }
                cards[index].isFaceUp = true
                cards[index].flipCount += 1
                cards[matchIndex].flipCount += 1
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        gameOver = isGameOver()
        if gameOver { highScore = score }
    }
    
    mutating func newGame() {
        score = 0
        flipCount = 0
        gameOver = false
    
        for index in cards.indices {
            cards[index].isMatched = false
            cards[index].isFaceUp = false
            cards[index].flipCount = 0
        }
        cards.shuffle()
    }
    
    init (numPairsOfCards: Int) {
        score = 0
        flipCount = 0
        gameOver = false
        for _ in 1...numPairsOfCards {
            let card = Card();
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    private func isGameOver() -> Bool {
        var allMatched = true
        for card in cards {
            if !card.isMatched {
                allMatched = false
                break
            }
        }
        return allMatched
    }
}
