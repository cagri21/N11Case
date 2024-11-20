//
//  ProductDetailViewController.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 18.11.2024.
//

import UIKit

protocol ProductDetailViewProtocol: AnyObject {
    func showLoading(_ isLoading: Bool)
    func showProducts()
    func showError(_ message: String)
}

class ProductDetailViewController: BaseViewController, ProductDetailViewProtocol {

    weak var presenter: ProductDetailPresenterProtocol!

    init(presenter: ProductsPresenterProtocol?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func showLoading(_ isLoading: Bool) {
        
    }
    
    func showProducts() {
        
    }
    
    func showError(_ message: String) {

    }
}
