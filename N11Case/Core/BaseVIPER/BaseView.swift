//
//  BaseView.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

protocol BaseViewProtocol: AnyObject {
    /// Show or hide a loading indicator.
    func showLoading(_ isLoading: Bool)

    /// Handle the response data.
    func showData()

    /// Display an error message.
    func showError(_ message: String)
}
