//
//  ViewController.swift
//  Playing Card
//
//  Created by Cassidy Caid on 1/28/19.
//  Copyright © 2019 Cassidy Caid. All rights reserved.
//
//  Background image photo by Aditya Chinchure on Unsplash

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //MARK: - Properties
    /***************************************************************/
    
    var deck = PlayingCardDeck()
    var drawPile = PlayingCardStack()
    
    //MARK: - IBOutlets and Actions
    /***************************************************************/
    
    @IBOutlet var cardView: [UIButton]!
    
    @IBAction func cardTouched(_ sender: UIButton) {
        if let index = cardView.firstIndex(of: sender) {
            if index == 0 {
                if deck.cards.count > 0 {
                    drawPile.cards.append(deck.deal()!)
                    cardView[1].isEnabled = true
                } else {
                    deck = PlayingCardDeck()
                    drawPile = PlayingCardStack()
                }
            } else if index == 1 {
                if drawPile.cards.count > 0 {
                    if drawPile.cards.last!.isFaceUp {
                        print(drawPile.drawTopCard()!)
                    } else {
                        cardView[1].setTitle(drawPile.showTopCard(), for: .normal)
                    }
                } else {cardView[index].isEnabled = false}
            }
            updateViewWithModel()
        }
    }
    
    //MARK: - Methods
    /***************************************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for _ in 1...10 {
            if let card = deck.deal() {
                print(card)
                drawPile.cards.append(card)
            }
        }
        updateViewWithModel()
    }
    
    private func updateViewWithModel() {
        cardView[0].setTitle(String(deck.cards.count), for: .normal)
        if drawPile.cards.last!.isFaceUp {
            cardView[1].setTitle(drawPile.showTopCard(), for: .normal)
            cardView[1].backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        } else {
            cardView[1].backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            cardView[1].setTitle(String(drawPile.cards.count), for: .normal)
        }
    }
    
    //MARK: - Haptic Feedback
    /***************************************************************/
    
    private func hapticFeedback(called name: String) {
        let haptics = ["peek" : 1519, "pop" : 1520, "cancelled" : 1521, "tryAgain" : 1102, "failed" : 1107, "vibrate" : 4095]
        if let vibrationID = haptics[name] {
            AudioServicesPlaySystemSound(SystemSoundID(vibrationID))
        }
    }
    
    //MARK: - Audio Feedback
    /***************************************************************/
    
    private func audioFeedback(_ name: String, dot ext: String) {
        if let fileURL = Bundle.main.url(forResource: name, withExtension: ext) {
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(fileURL as CFURL, &mySound)
            AudioServicesPlaySystemSound(mySound)
        } else {print("Sound File: \(name).\(ext) NOT FOUND")}
    }
    
    //MARK: - Shake Detected
    /***************************************************************/
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        audioFeedback("metronome", dot: "wav")
        hapticFeedback(called: "pop")
        
    }
    
    
    
}
