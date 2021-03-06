//
//  Concentration.swift
//  Concentration
//
//  Created by Nathan Billis on 26/12/2018.
//  Copyright © 2018 Nathan Billis. All rights reserved.
//

import Foundation

struct Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        // Check to see if the Card is the one and only
        get{
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index:Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                // Check if they match
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }
            else{
                // Either Two or No Cards are Face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least on pair of cards")
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            
            // two diffrent cards in memory
            cards += [card, card]
        }
        //Shuffle Cards
        cards = shuffleCards(with: cards)
    }
    
    private func shuffleCards(with cardArray: [Card]) -> [Card] {
        var Cards = cardArray
        var tempCards = Cards
        
        for cardnumber in 0..<Cards.count{
            let randomIndex = Cards.count.arc4random
            tempCards[cardnumber] = Cards.remove(at: randomIndex)
        }
        return tempCards
    }
    
    mutating func NewGame() {
        for index in 0..<cards.count{
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        cards = shuffleCards(with: cards)
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
