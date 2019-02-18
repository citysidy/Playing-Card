//
//  PlayingCardStack.swift
//  Playing Card
//
//  Created by Cassidy Caid on 1/30/19.
//  Copyright © 2019 Cassidy Caid. All rights reserved.
//

import Foundation

struct PlayingCardStack {
    
    //MARK: - Properties
    /***************************************************************/
    
    var cards = [PlayingCard]()
    var count: Int {
        return cards.count
    }
    
    var topCard: PlayingCard? {
        if count > 0 {
            return cards.last
        } else {return nil}
    }
    
    //MARK: - Methods
    /***************************************************************/
    
    mutating func drawTopCard() -> PlayingCard? {
        if count < 1 {return nil} else {
            cards[count.lessOne].isFaceUp = false
            return cards.remove(at: count.lessOne)
        }
    }
    
    mutating func showTopCard() -> String? {
        if count < 1  {return nil} else {
            cards[count.lessOne].isFaceUp = true
            return cards.last!.description
        }
    }
    
    
    
}
