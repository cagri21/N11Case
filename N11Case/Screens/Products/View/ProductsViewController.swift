//
//  ProductsViewController.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//
import NetworkProvider
import ProgressHUD
import UIKit

protocol ProductsViewProtocol: BaseViewProtocol {}

final class ProductsViewController: BaseViewController, ProductsViewProtocol, UICollectionViewDelegate {
    @IBOutlet var productsCollectionView: UICollectionView! {
        didSet {
            productsCollectionView.delegate = self
            productsCollectionView.dataSource = self

            productsCollectionView.registerNib(for: NormalProductCell.self)
            productsCollectionView.registerNib(for: SponsoredProductCell.self)
            productsCollectionView.translatesAutoresizingMaskIntoConstraints = false
            productsCollectionView.register(
                    SectionPagerView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: SectionPagerView().className
                )
            let layout: UICollectionViewLayout = CustomProductLayoutProvider().createLayout()
            productsCollectionView.setCollectionViewLayout(layout, animated: true)
        }
    }

    internal var presenter: ProductsPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
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
        DispatchQueue.main.async {
            self.productsCollectionView.reloadData()
        }
    }

    func showError(_ message: String) {
        print("Error: \(message)")
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Handle vertical scrolling for pagination
        if scrollView == productsCollectionView && !productsCollectionView.isPagingEnabled {
            let offsetY: Double = scrollView.contentOffset.y
            let contentHeight: Double = scrollView.contentSize.height
            let frameHeight: Double = Double(scrollView.frame.height) // Explicitly cast frame height to Double

            if offsetY > contentHeight - (frameHeight * 2) {
                presenter?.fetchNextPage()
            }
        }
    }

}
