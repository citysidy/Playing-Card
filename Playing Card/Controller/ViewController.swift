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
    
   
    
    //MARK: - Methods
    /***************************************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
