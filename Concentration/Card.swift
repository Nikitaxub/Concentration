//
//  Card.swift
//  Concentration
//
//  Created by Ivanych Puy on 02.05.2020.
//  Copyright © 2020 xubuntus. All rights reserved.
//

import Foundation

struct Card: Hashable
{
//    static func == (lhs: Card, rhs: Card) -> Bool {
//        return lhs.idenntifier == rhs.idenntifier
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(idenntifier)
//    }
    
    var isFaceUp = false
    var isMatched = false
    private var idenntifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.idenntifier = Card.getUniqueIdentifier()
    }
}
