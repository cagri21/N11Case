//
//  BaseInteractor.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

protocol BaseInteractorOutputProtocol: AnyObject {
    associatedtype Response
    func didFetchData(_ response: Response)
    func didFailToFetchData(_ errorMessage: String)
}

protocol BaseInteractorProtocol: AnyObject {
    associatedtype Entity
    func getEntity() -> Entity
}
