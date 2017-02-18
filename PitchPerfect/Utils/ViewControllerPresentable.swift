//
//  ViewControllerPresentable.swift
//  PitchPerfect
//
//  Created by Boxuan Zhang on 2/17/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import UIKit

protocol ViewControllerPresentable {
    func present(_ viewController: UIViewController,
                 from aViewController: UIViewController,
                 animated: Bool,
                 completion: (() -> Void)?)
}

class ViewControllerPresenter: ViewControllerPresentable {
    static let shared = ViewControllerPresenter()
    
    func present(_ viewController: UIViewController,
                 from aViewController: UIViewController,
                 animated: Bool,
                 completion: (() -> Void)?) {
        
        aViewController.present(viewController, animated: animated, completion: completion)
    }
}
