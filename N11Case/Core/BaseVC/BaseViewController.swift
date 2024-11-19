//
//  BaseViewController.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 17.11.2024.
//

import NetworkProvider
import UIKit

class BaseViewController: UIViewController, Viewable {

    deinit {
        DLog("\(BaseViewController.self): deinitialized")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
    }

}
