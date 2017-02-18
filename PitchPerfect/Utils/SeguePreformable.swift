//
//  SeguePreformable.swift
//  PitchPerfect
//
//  Created by Boxuan Zhang on 2/17/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import UIKit

protocol SeguePerformable {
    func performSegue(with identifier: String,
                      sender: Any?,
                      from viewController: UIViewController)
}

class SeguePerformer: SeguePerformable {
    static let shared = SeguePerformer()
    
    func performSegue(with identifier: String, sender: Any?, from viewController: UIViewController) {
        viewController.performSegue(withIdentifier: identifier, sender: sender)
    }
}

