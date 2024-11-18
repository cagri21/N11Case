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
                    withReuseIdentifier: SectionPagerView.reuseIdentifier
                )
//            let layoutProvider = ItemListCollectionViewLayoutProvider()
//            let hasSponsoredSection = presenter.numberOfSections() > 1
//            let layout = layoutProvider.createLayout(hasSponsoredSection: hasSponsoredSection)
            let layout = CustomProductLayout.createLayout()
            productsCollectionView.setCollectionViewLayout(layout, animated:   true)
//            productsCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
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
            print("Content Size after reloadData: \(self.productsCollectionView.contentSize)")
        }
    }

    func showError(_ message: String) {
        print("Error: \(message)")
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == productsCollectionView {
               print("ScrollView contentOffset: \(scrollView.contentOffset)")
        }
        // Handle vertical scrolling for pagination
        if scrollView == productsCollectionView && !productsCollectionView.isPagingEnabled {
            let offsetY: Double = scrollView.contentOffset.y
            let contentHeight: Double = scrollView.contentSize.height
            let frameHeight: Double = Double(scrollView.frame.height) // Explicitly cast frame height to Double

            if offsetY > contentHeight - (frameHeight * 2) {
                presenter?.fetchNextPage()
            }
        }

        // Handle horizontal scrolling for updating the page control (sponsored section)
        let sponsoredSectionIndex: Int = 0 // Assuming the sponsored section is the first section

        guard let productsPresenter = presenter as? ProductsPresenter,
              productsPresenter.sections.indices.contains(sponsoredSectionIndex),
              case .sponsored(let products) = productsPresenter.sections[sponsoredSectionIndex] else {
            return
        }

        // Ensure the horizontal scrolling is being handled
        if scrollView == productsCollectionView && productsCollectionView.isPagingEnabled {
            // Calculate the current page for the sponsored section
            let currentPage: Int = Int((scrollView.contentOffset.x + (0.5 * scrollView.frame.width)) / scrollView.frame.width)
            print("Current Page: \(currentPage)")

            // Update the pager view in the footer
            if let pagerView = productsCollectionView.supplementaryView(
                forElementKind: UICollectionView.elementKindSectionFooter,
                at: IndexPath(item: 0, section: sponsoredSectionIndex)
            ) as? SectionPagerView {
                pagerView.configure(with: products.count, currentPage: currentPage)
            }
        }
    }
    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        guard scrollView == productsCollectionView else { return }
//
//        let sponsoredSectionIndex = 0
//
//        if let productsPresenter = presenter as? ProductsPresenter,
//           productsPresenter.sections.indices.contains(sponsoredSectionIndex),
//           case .sponsored = productsPresenter.sections[sponsoredSectionIndex] {
//            productsCollectionView.isPagingEnabled = true // Enable paging for horizontal scrolling
//        } else {
//            productsCollectionView.isPagingEnabled = false // Disable for vertical scrolling
//        }
//    }

}
// swiftlint:disable no_grouping_extension
extension ProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let productsPresenter = presenter as? ProductsPresenter else {
            return UICollectionViewCell()
        }

        let section: SectionType = productsPresenter.sections[indexPath.section]

        switch section {
        case .sponsored(let products):
            let cell: SponsoredProductCell = productsCollectionView.dequeueReusableCell(for: indexPath)
            let product: ProductDisplayable = products[indexPath.item]
            cell.configure(with: product)
            return cell
        case .products(let products):
            let cell: NormalProductCell = productsCollectionView.dequeueReusableCell(for: indexPath)
            let product: ProductDisplayable = products[indexPath.item]
            cell.configure(with: product)
            return cell
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let numberOfSection: Int = presenter.numberOfSections()
        print("Number Of Section is \(numberOfSection)")
        return numberOfSection
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems: Int = presenter.numberOfItems(in: section)
        print("Number Of Items is \(numberOfItems)")
        return numberOfItems
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let productsPresenter = presenter as? ProductsPresenter else {
            return UICollectionReusableView()
        }

        let section = productsPresenter.sections[indexPath.section]

        // Check for Sponsored Section Footer
        if kind == UICollectionView.elementKindSectionFooter, case .sponsored(let products) = section {
            // Create and configure the pager view for the sponsored section
            let pagerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionPagerView.reuseIdentifier,
                for: indexPath
            ) as! SectionPagerView
            pagerView.configure(with: products.count, currentPage: 0) // Start with the first page
            return pagerView
        }

        return UICollectionReusableView()
    }
}
// swiftlint:enable no_grouping_extension

