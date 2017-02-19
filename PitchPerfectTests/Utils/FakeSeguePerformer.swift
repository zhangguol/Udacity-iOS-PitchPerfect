//
//  FakeSeguePerformer.swift
//  PitchPerfect
//
//  Created by Boxuan Zhang on 2/19/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import UIKit
@testable import PitchPerfect

class FakeSeguePerformer: SeguePerformable {
    
    var performSegue_wasCalled = false
    var performSegue_wasCalled_withArgs: (identifier: String, sender: Any?, from: UIViewController)?
    func performSegue(with identifier: String, sender: Any?, from viewController: UIViewController) {
        
        performSegue_wasCalled = true
        performSegue_wasCalled_withArgs = (identifier, sender, viewController)
    }
}
