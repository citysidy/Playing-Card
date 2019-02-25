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
    
    var countLessOne: Int {
        return cards.count - 1
    }
    
    //MARK: - Methods
    /***************************************************************/
    
    mutating func draw() -> PlayingCard? {
        if cards.count == 0 {return nil} else {
            return cards.remove(at: countLessOne)
        }
    }
    
    mutating func discard(_ card: PlayingCard) {
        cards.append(card)
    }
    
}
