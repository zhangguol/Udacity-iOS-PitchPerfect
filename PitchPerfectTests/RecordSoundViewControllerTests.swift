//
//  RecordSoundViewControllerTests.swift
//  PitchPerfect
//
//  Created by Boxuan Zhang on 2/19/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import XCTest
@testable import PitchPerfect
import AVFoundation

class RecordSoundViewControllerTests: XCTestCase {

    var sut: RecordSoundsViewController!
    var fakePresenter: FakePresenter!
    var fakeSeguePerformer: FakeSeguePerformer!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "RecordSoundsViewController") as! RecordSoundsViewController
       
        fakePresenter = FakePresenter()
        sut.presenter = fakePresenter
       
        fakeSeguePerformer = FakeSeguePerformer()
        sut.seguePerformer = fakeSeguePerformer
        
        _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
        
        if let recorder = sut.audioRecorder, recorder.isRecording {
            recorder.stop()
        }
    }

    func testViewDidLoad() {
        XCTAssertEqual(sut.recordingLabel.text, "Tap to Record")
        XCTAssertEqual(sut.recordButton.isEnabled, true)
        XCTAssertEqual(sut.stopRecordingButton.isEnabled, false)
    }
    
    func testRecordAudio() {
        sut.recordButton.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(sut.recordingLabel.text, "Recording in progress")
        XCTAssertEqual(sut.recordButton.isEnabled, false)
        XCTAssertEqual(sut.stopRecordingButton.isEnabled, true)
    
        XCTAssertTrue(sut.audioRecorder != nil)
        XCTAssertTrue(sut.audioRecorder!.delegate === sut)
        XCTAssertEqual(sut.audioRecorder!.isMeteringEnabled, true)
        
        
        XCTAssertEqual(sut.audioRecorder!.url, Resource.fileURL)
        
        XCTAssertTrue(sut.audioRecorder!.isRecording)
    }
    
    func testStopRecording() {
        sut.recordButton.sendActions(for: .touchUpInside)
        sut.stopRecordingButton.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(sut.recordingLabel.text, "Tap to Record")
        XCTAssertEqual(sut.recordButton.isEnabled, true)
        XCTAssertEqual(sut.stopRecordingButton.isEnabled, false)
        
        XCTAssertEqual(sut.audioRecorder!.isRecording, false)
    }
    
    func testAudioRecorderDidFinishRecordingSuccessfully() {
        sut.audioRecorder = try! AVAudioRecorder(url: Resource.fileURL, settings: [:])
        sut.audioRecorderDidFinishRecording(sut.audioRecorder!, successfully: true)
        
        XCTAssertTrue(fakeSeguePerformer.performSegue_wasCalled)
        let args = fakeSeguePerformer.performSegue_wasCalled_withArgs!
        XCTAssertEqual(args.identifier, RecordSoundsViewController.SegueIdentifier.stopRecording)
        XCTAssertEqual(args.sender as! URL, Resource.fileURL)
        XCTAssertTrue(args.from === sut)
    }
    
    func testAudioRecorderDidFinishRecordingFailed() {
        sut.audioRecorder = try! AVAudioRecorder(url: Resource.fileURL, settings: [:])
        sut.audioRecorderDidFinishRecording(sut.audioRecorder!, successfully: false)
    
        XCTAssertTrue(fakePresenter.present_wasCalled)
        XCTAssertTrue(fakePresenter.present_wasCalled_withArgs!.viewController is UIAlertController)
    }
    
    func testPrepareForSegue() {
        
        let destination = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "PlaySoundsViewController") as! PlaySoundsViewController
        let segue = UIStoryboardSegue(identifier: RecordSoundsViewController.SegueIdentifier.stopRecording,
                                      source: sut,
                                      destination: destination)
        sut.prepare(for: segue, sender: Resource.fileURL)
        
        XCTAssertEqual(destination.recordedAudioURL!, Resource.fileURL)
    }
    
}

fileprivate extension RecordSoundViewControllerTests {
    enum Resource {
        static let fileURL: URL = {
            let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                              .userDomainMask,
                                                              true)[0]
            let recordingName = "recordedVoice.wav"
            let pathArray = [dirPath, recordingName]
            return URL(string: pathArray.joined(separator: "/"))!
        }()
    }
}













