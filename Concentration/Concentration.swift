//
//  Concentration.swift
//  Concentration
//
//  Created by Nathan Billis on 26/12/2018.
//  Copyright © 2018 Nathan Billis. All rights reserved.
//

import Foundation

class Concentration
{
    private(set) var cards = [Card]()
    
    // Int is of type Optional
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        // Computed proprties
        get{
            var foundIndex: Int?
            
            for index in cards.indices{
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
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index:Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                // Check if they match
                if cards[matchIndex].identifier == cards[index].identifier{
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
    
    func NewGame() {
        for index in 0..<cards.count{
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        cards = shuffleCards(with: cards)
    }
}
