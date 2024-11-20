//
//  SectionPagerView.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 18.11.2024.
//

import UIKit

class SectionPagerView: UICollectionReusableView {

    private let pageControl: UIPageControl = {
        let pageControl: UIPageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        return pageControl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPageControl()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPageControl()
    }

    private func setupPageControl() {
        addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func configure(with numberOfPages: Int, currentPage: Int) {
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = currentPage
    }

    /// Exposes page control configuration for testing purposes.
    func getCurrentConfiguration() -> (numberOfPages: Int, currentPage: Int) {
        let configuration: (numberOfPages: Int, currentPage: Int) = (numberOfPages: pageControl.numberOfPages, currentPage: pageControl.currentPage)
        return configuration
    }
}
