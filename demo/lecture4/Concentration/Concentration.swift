//
//  Concentration.swift
//  Concentration
//
//  Created by 张龙翔 on 2021/5/10.
//

import Foundation

class Concentration{
    private(set) var cards = [Card]()
    var isFinishedGame: Bool = false
    // MARK: variable
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            return cards.indices.filter {
                cards[$0].isFaceUp
            }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    private(set) var flipCount = 0
    var score: Int
    
    // MARK: function
    func chooseCard(at Index: Int){
        assert(cards.indices.contains(Index), "Concentration.chooseCard(at: \(Index)): chosen index")
        flipCount += 1
        
        if !cards[Index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != Index {
                //check if card match
                if cards[matchIndex] == cards[Index] {
                    //两个匹配，得两分
                    cards[matchIndex].isMatched = true
                    cards[Index].isMatched = true
                    score += 2
                } else {
                    //两个只要有一个看到过就扣一分
                    if (cards[matchIndex].isSeenBefore || cards[Index].isSeenBefore) {
                        score -= 1
                    }
                    cards[Index].isSeenBefore = true
                    cards[matchIndex].isSeenBefore = true
                }
                cards[Index].isFaceUp = true
             } else {
                //neither no cards or 2 cards are faced up

                indexOfOneAndOnlyFaceUpCard = Index
            }
        }
        var b = true
        for card in cards {
            b = card.isMatched && b
        }
        isFinishedGame = b
        print(isFinishedGame)
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards))")
        score = 0
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //TODO: shuffle the cards
        for _ in 1...1000 {
            for index in cards.indices {
                let randomIndex = cards.count.arc4Random
                let temp = cards[index]
                cards[index] = cards[randomIndex]
                cards[randomIndex] = temp
            }
        }
        
        
    }
    
}

extension Collection {
    var oneAndOnly : Element? {
        return count == 1 ? first : nil
    }
    
}
