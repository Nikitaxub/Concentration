//
//  Concentration.swift
//  Concentration
//
//  Created by Ivanych Puy on 02.05.2020.
//  Copyright © 2020 xubuntus. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    private (set) var flipCount = 0
    
    var score = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex : Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set (newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    var flipedCards: [Int] = []
    
    var lastFlipDate: Date?
    
    // коэффициент 2 за медлительность (дольше 5 сек)
    func sluggishSlowCoef() -> Int {
        if lastFlipDate != nil, lastFlipDate!.timeIntervalSinceNow > -5 {
            return 1
        } else {
            return 2
        }
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2 / sluggishSlowCoef()
                } else {
                    for flipedIndex in [index, matchIndex] {
                        if flipedCards.contains(flipedIndex) {
                            score -= 1 * sluggishSlowCoef()
                        } else {
                            flipedCards.append(flipedIndex)
                        }
                    }
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        lastFlipDate = Date()
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
