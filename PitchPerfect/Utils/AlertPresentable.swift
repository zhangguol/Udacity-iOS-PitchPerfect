//
//  AlertPresentable.swift
//  PitchPerfect
//
//  Created by Boxuan Zhang on 2/17/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import UIKit

protocol AlertPresentable {
    var presenter: ViewControllerPresentable { get }
}

extension AlertPresentable where Self: UIViewController {
    var presenter: ViewControllerPresentable {
        return ViewControllerPresenter.shared
    }

    func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        presenter.present(alert, from: self, animated: true, completion: nil)
    }
}
