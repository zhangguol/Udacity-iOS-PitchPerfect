//
//  PlaySoundsViewControllerTests.swift
//  PitchPerfect
//
//  Created by Boxuan Zhang on 2/21/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import XCTest
@testable import PitchPerfect

class PlaySoundsViewControllerTests: XCTestCase {

    var sut: PlaySoundsViewController!

    var playButtons: [UIButton] {
        return [
            sut.snailButton,
            sut.chipmunkButton,
            sut.rabbitButton,
            sut.vaderButton,
            sut.echoButton,
            sut.reverbButton
        ]
    }
    
    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "PlaySoundsViewController") as! PlaySoundsViewController

        _ = sut.view
    }

    func testButtonTags() {
        XCTAssertEqual(sut.snailButton.tag, 0)
        XCTAssertEqual(sut.rabbitButton.tag, 1)
        XCTAssertEqual(sut.chipmunkButton.tag, 2)
        XCTAssertEqual(sut.vaderButton.tag, 3)
        XCTAssertEqual(sut.echoButton.tag, 4)
        XCTAssertEqual(sut.reverbButton.tag, 5)
    }

    func testInitialUIState() {
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()

        for button in playButtons {
            XCTAssertEqual(button.isEnabled, true)
        }
        XCTAssertEqual(sut.stopButton.isEnabled, false)
    }

    func testPlayingUISate() {
        sut.playSoundForButton(UIButton())
        
        for button in playButtons {
            XCTAssertEqual(button.isEnabled, false)
        }
        XCTAssertEqual(sut.stopButton.isEnabled, true)
    }
}
