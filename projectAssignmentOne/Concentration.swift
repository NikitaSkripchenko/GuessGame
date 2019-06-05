//
//  Concentation.swift
//  projectAssignmentOne
//
//  Created by Nikita Skrypchenko  on 11/25/18.
//  Copyright © 2018 Nikita Skrypchenko . All rights reserved.
//

import Foundation

extension Date{
    var sinceNow:Int{
        return -Int(self.timeIntervalSinceNow)
    }
}

struct Concentration {
    private(set) var cards = [Card]()
    var score = 0
    
    private var seenCards: Set<Int> = []
    private var dateClick:Date?
    
    var timePenalty:Int {
        return min(dateClick?.sinceNow ?? 0, Points.maxTimePenalty)
    }
    
    private struct Points {
        static let matchBonus = 20
        static let missMatchPenalty = 10
        static let maxTimePenalty = 10
    }
    
    private var indexoneOfOneAndOnlyFacedUpCard: Int?{
        get{
            var foundIndex:Int?
            for index in cards.indices{
                if cards[index].isFacedUp{
                    guard foundIndex == nil else { return nil }
                    foundIndex = index
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFacedUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index:Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : Choosen index out of range")
        if !cards[index].isMatched {
            if let matchIndex = indexoneOfOneAndOnlyFacedUpCard, matchIndex != index{
                if cards[index] == cards[matchIndex]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    score += Points.matchBonus
                }else{
                    if seenCards.contains(index) || seenCards.contains(matchIndex){
                        score -= Points.missMatchPenalty
                    }
                    seenCards.insert(index)
                    //seenCards.insert(matchIndex)
                }
                score -= timePenalty 
                cards[index].isFacedUp = true
            }else{
                indexoneOfOneAndOnlyFacedUpCard = index
            }
            dateClick = Date()
        }
    }
    
    mutating func resetGame() {
        for index in cards.indices{
            cards[index].isFacedUp = false
            cards[index].isMatched = false
        }
        score = 0
        seenCards = []
        cards.shuffle()
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(at: \(numberOfPairsOfCards)) : Must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
}
