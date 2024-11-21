//
//  BaseInteractor.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

protocol BaseInteractorOutputProtocol: AnyObject {
    associatedtype Response
    func didFetchData()
    func didFailToFetchData(_ errorMessage: String)
}

protocol BaseInteractorProtocol: AnyObject {
    associatedtype Entity

    var entity: Entity { get }
}
