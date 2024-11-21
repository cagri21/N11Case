//
//  ProductDetailViewController.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 18.11.2024.
//

import Cosmos
import ProgressHUD
import UIKit

protocol ProductDetailViewProtocol: BaseViewProtocol {}

class ProductDetailViewController: BaseViewController, ProductDetailViewProtocol {
    @IBOutlet weak var detailCollectionView: UICollectionView! {
        didSet {
            detailCollectionView.delegate = self
            detailCollectionView.dataSource = self

            detailCollectionView.registerNib(for: ProductDetailCollectionViewCell.self)
            detailCollectionView.translatesAutoresizingMaskIntoConstraints = false
            detailCollectionView.register(
                    SectionPagerView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: SectionPagerView().className
                )
            let layout: UICollectionViewLayout = CustomProductLayoutProvider().createHorizontalLayout()
            detailCollectionView.setCollectionViewLayout(layout, animated: true)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sellerLabel: UILabel!

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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.detailCollectionView.reloadData()
            self.setDetails()
        }
    }

    func showError(_ message: String) {
        AlertPresenter().presentAlert(title: Alert.errorTitle, message: message)
    }

    private func setDetails() {
        if let productDetails = presenter?.getProduct() {
            titleLabel.text = productDetails.title
            descriptionLabel.text = productDetails.description
            priceLabel.text = CurrencyFormatter.turkey.format(price: productDetails.price)
            sellerLabel.text = productDetails.sellerName

            if let discountPrice = productDetails.discountedPrice {
                discountPriceLabel.text = CurrencyFormatter.turkey.format(price: discountPrice)
                priceLabel.strikeThrough(true)
            } else {
                discountPriceLabel.isHidden = true
            }

            if let rating = productDetails.rate {
                rateView.settings.starSize = 25
                rateView.rating = rating
                rateView.isHidden = false
            }
        }
    }
}
