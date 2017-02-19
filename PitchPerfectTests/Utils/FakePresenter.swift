//
//  FakePresenter.swift
//  PitchPerfect
//
//  Created by Boxuan Zhang on 2/19/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import UIKit
@testable import PitchPerfect

class FakePresenter: ViewControllerPresentable {
    
    var present_wasCalled = false
    var present_wasCalled_withArgs: (viewController: UIViewController, from: UIViewController, animated: Bool, completion: (() -> Void)?)?
    func present(_ viewController: UIViewController, from aViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        
        present_wasCalled = true
        present_wasCalled_withArgs = (viewController, aViewController, animated, completion)
    }
}
