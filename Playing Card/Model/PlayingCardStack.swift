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
    
    var topCard: PlayingCard? {
        if countLessOne >= 0 {
            return cards.last
        } else {return nil}
    }
    
    //MARK: - Methods
    /***************************************************************/
    
    mutating func drawTopCard() -> PlayingCard? {
        if countLessOne < 1 {return nil} else {
            return cards.remove(at: countLessOne)
        }
    }
    
    mutating func showTopCard() -> String? {
        if countLessOne < 1  {return nil} else {
            return cards.last!.description
        }
    }
    
    
    
}
