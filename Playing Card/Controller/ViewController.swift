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
    
    
    //MARK: - IBOutlets and Actions
    /***************************************************************/
    
    @IBOutlet weak var playingCardView: PlayingCardView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left,.right]
            playingCardView.addGestureRecognizer(swipe)
            let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(PlayingCardView.adjustFaceCardScale(byHandlingGestureRecognizedBy:)))
            playingCardView.addGestureRecognizer(pinch)
        }
    }
    
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            playingCardView.isFaceUp = !playingCardView.isFaceUp
        default: break
        }
    }
    
    //MARK: - Methods
    /***************************************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @objc func nextCard() {
        if let card = deck.deal() {
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
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
