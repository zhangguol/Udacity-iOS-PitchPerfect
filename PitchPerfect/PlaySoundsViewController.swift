//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Boxuan Zhang on 2/17/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL?
    var audioFile:AVAudioFile?
    var audioEngine:AVAudioEngine?
    var audioPlayerNode: AVAudioPlayerNode?
    var stopTimer: Timer?

    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureUI(.notPlaying)
    }

    // MARK: - IBActions
    @IBAction func playSoundForButton(_ sender: UIButton) {
        guard let type = ButtonType(rawValue: sender.tag) else {
            fatalError("Wrong button tag")
        }

        configureUI(.playing)
        switch type {
        case .slow: playSound(rate: 0.5)
        case .fast: playSound(rate: 1.5)
        case .chipmunk: playSound(pitch: 1000)
        case .vader: playSound(pitch: -1000)
        case .echo: playSound(echo: true)
        case .reverb: playSound(reverb: true)
        }
    }

    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
}
