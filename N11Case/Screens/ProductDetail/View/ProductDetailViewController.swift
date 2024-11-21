//
//  ProductDetailViewController.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 18.11.2024.
//

import ProgressHUD
import UIKit

protocol ProductDetailViewProtocol: BaseViewProtocol {}

class ProductDetailViewController: BaseViewController, ProductDetailViewProtocol {

    internal var presenter: ProductDetailPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func showLoading(_ isLoading: Bool) {
        if isLoading {
            ProgressHUD.animationType = .activityIndicator
            ProgressHUD.animate("Please wait...")
        } else {
            ProgressHUD.dismiss()
        }
    }

    func showData() {
    }

    func showError(_ message: String) {
        AlertPresenter().presentAlert(title: Alert.errorTitle, message: message)
    }
}
