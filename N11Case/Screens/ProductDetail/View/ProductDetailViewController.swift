//
//  ProductDetailViewController.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 18.11.2024.
//

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

    }
    
    func showData() {
        print("data")
    }
    
    func showError(_ message: String) {

    }
}
