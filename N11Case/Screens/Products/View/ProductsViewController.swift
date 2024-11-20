//
//  ProductsViewController.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//
import NetworkProvider
import ProgressHUD
import UIKit

protocol ProductsViewProtocol: AnyObject {
    func showLoading(_ isLoading: Bool)
    func showProducts()
    func showError(_ message: String)
}

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

    var presenter: ProductsPresenterProtocol!

    init(presenter: ProductsPresenterProtocol?) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    func showProducts() {
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
// swiftlint:disable no_grouping_extension
extension ProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType: SectionType = presenter.sectionType(at: indexPath.section)
        let product: ProductDisplayable = presenter.product(at: indexPath)

        switch sectionType {
        case .sponsored:
            let cell: SponsoredProductCell = productsCollectionView.dequeueReusableCell(for: indexPath)
            cell.configure(with: product as! SponsoredProduct)
            return cell
        case .products:
            let cell: NormalProductCell = productsCollectionView.dequeueReusableCell(for: indexPath)
            cell.configure(with: product as! Product)
            return cell
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let numberOfSection: Int = presenter.numberOfSections()
        return numberOfSection
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems: Int = presenter.numberOfItems(in: section)
        return numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionType: SectionType = presenter.sectionType(at: indexPath.section)
        // Check for Sponsored Section Footer
        if kind == UICollectionView.elementKindSectionFooter, case .sponsored(let products) = sectionType {
            // Create and configure the pager view for the sponsored section
            let pagerView: SectionPagerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionPagerView().className, for: indexPath) as! SectionPagerView
            pagerView.configure(with: products.count, currentPage: 0) // Start with the first page
            return pagerView
        }

        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let sectionType: SectionType = presenter.sectionType(at: indexPath.section)

        if case .sponsored(let products) = sectionType {
                if let pagerView = productsCollectionView.supplementaryView(
                    forElementKind: UICollectionView.elementKindSectionFooter,
                    at: IndexPath(item: 0, section: indexPath.section)
                ) as? SectionPagerView {
                    pagerView.configure(with: products.count, currentPage: indexPath.row)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            DLog("\(ProductsViewController.self): cell couln't find in cell at didSelectItemAt.")
            return
        }

           // Trigger fade animation
        cell.animateFade { [weak self] in
            guard let self = self else {
                DLog("\(ProductsViewController.self): Self couln't find in cell click animation.")
                return
            }
            // Get the selected product
            let selectedProduct: ProductDisplayable = presenter.product(at: indexPath)

            // Delegate the selection to the presenter
            presenter.didSelectProduct(selectedProduct)
        }
        // Get the section type for the selected item
    }
}
// swiftlint:enable no_grouping_extension
