//
//  ProductsViewController.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//
import NetworkProvider
import UIKit

protocol ProductsViewProtocol: AnyObject {
    func showLoading(_ isLoading: Bool)
    func showProducts()
    func showError(_ message: String)
}

final class ProductsViewController: UIViewController, ProductsViewProtocol, UICollectionViewDelegate {
    @IBOutlet var productsCollectionView: UICollectionView! {
        didSet {
            productsCollectionView.delegate = self
            productsCollectionView.dataSource = self
            productsCollectionView.registerNib(for: NormalProductCell.self)
            productsCollectionView.registerNib(for: SponsoredProductCell.self)
            productsCollectionView.translatesAutoresizingMaskIntoConstraints = false
//            let layoutProvider = ItemListCollectionViewLayoutProvider()
//            let hasSponsoredSection = presenter.numberOfSections() > 1
//            let layout = layoutProvider.createLayout(hasSponsoredSection: hasSponsoredSection)
            let layout = CompositionalLayoutProvider.createLayout()
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
            print("IsLoading: \(isLoading)")
        } else {
            print("IsLoading: \(isLoading)")
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
        let offsetY: Double = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height * 2 {
            presenter?.fetchNextPage()
        }
    }

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
}
// swiftlint:enable no_grouping_extension
