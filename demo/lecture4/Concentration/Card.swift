//
//  Card.swift
//  Concentration
//
//  Created by 张龙翔 on 2021/5/10.
//

import Foundation

struct Card: Hashable {
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(isFaceUp)
//        hasher.combine(isMatched)
//        hasher.combine(isSeenBefore)
//        hasher.combine(identifier)
//    }
    var isFaceUp = false
    var isMatched = false
    var isSeenBefore = false
    private var identifier: Int
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1;
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    var hashValue: Int {
        return identifier
    }

    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
