//
//  Card.swift
//  Concentration
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactor = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactor += 1
        return identifierFactor
    }
    
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}






