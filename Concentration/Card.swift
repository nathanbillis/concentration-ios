//
//  Card.swift
//  Concentration
//
//  Created by Nathan Billis on 26/12/2018.
//  Copyright © 2018 Nathan Billis. All rights reserved.
//

import Foundation
//  part of the Model

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
