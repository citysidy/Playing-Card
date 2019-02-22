//
//  PlayingCardDeck.swift
//  Playing Card
//
//  Created by Cassidy Caid on 1/29/19.
//  Copyright © 2019 Cassidy Caid. All rights reserved.
//

import Foundation

struct PlayingCardDeck {
    
    //MARK: - Properties
    /***************************************************************/
    
    private(set) var cards = [PlayingCard]()
    
    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }
    
    
    //MARK: - Methods
    /***************************************************************/
    
    mutating func deal() -> PlayingCard? {
        if cards.count == 0 {return nil}
        return cards.remove(at: cards.count.shuffle)
    }
    
}


//MARK: - Extensions
/***************************************************************/

extension Int {
    var shuffle: Int {
        if self > 0 {
            return +Int.random(in: 0 ..< +self)
        }
        
        else
        if self < 0 {
            return -Int.random(in: 0 ..< -self)
        }
        
        else {return 0}
    }
    
}

extension Sequence {
    func count(_ isValid: ((Iterator.Element) -> Bool)) -> Int {
        var validItems = 0
        for element in self {
            if isValid(element) {
                validItems += 1
            }
        }
        return validItems
    }
    
}
