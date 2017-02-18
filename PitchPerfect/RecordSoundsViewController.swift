//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Boxuan Zhang on 2/17/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!

    // MARK: Properties
    var audioRecorder: AVAudioRecorder?

    // MARK: Dependence Injections
    var presenter: ViewControllerPresentable = ViewControllerPresenter.shared
    var seguePerformer: SeguePerformable = SeguePerformer.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure(viewState: .notRecording)
    }

    // MARK: - IBActions
    @IBAction func recordAudio(_ sender: UIButton) {
        configure(viewState: .recording)

        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                          .userDomainMask,
                                                          true)[0]
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        guard let filePath = URL(string: pathArray.joined(separator: "/")) else {
            showErrorAlert(with: "Cannot record audio, please try again")
            return
        }

        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord,
                                     with: .defaultToSpeaker)
            audioRecorder = try AVAudioRecorder(url: filePath, settings: [:])

            audioRecorder?.delegate = self
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
        } catch let error {
            showErrorAlert(with: "Cannot record audio, please try again\n\(error.localizedDescription)")
        }
    }

    @IBAction func stopRecording(_ sender: UIButton) {
        configure(viewState: .notRecording)

        audioRecorder?.stop()
        try? AVAudioSession.sharedInstance().setActive(false)
    }

    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case SegueIdentifier.stopRecording?:
            (segue.destination as? PlaySoundsViewController)?.recordedAudioURL = sender as? URL
        default: break
        }
    }
}

// MARK: - View State
fileprivate extension RecordSoundsViewController {
    enum State {
        case recording, notRecording
    }

    func configure(viewState: State) {
        recordingLabel.text = viewState == .notRecording ? "Tap to Record"
                                                         : "Recording in progress"
        recordButton.isEnabled = viewState == .notRecording
        stopRecordingButton.isEnabled = viewState == .recording
    }
}

// MARK: - AVAudioRecorderDelegate
extension RecordSoundsViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        guard flag && recorder == self.audioRecorder else {
            showErrorAlert(with: "Cannot record audio, please try again")
            return
        }

        seguePerformer.performSegue(with: SegueIdentifier.stopRecording, sender: recorder.url, from: self)
    }
}

// MARK: - Constants
extension RecordSoundsViewController {
    enum SegueIdentifier {
        static let stopRecording = "stopRecording"
    }
}

// MARK: - Alert
extension RecordSoundsViewController: AlertPresentable {}

