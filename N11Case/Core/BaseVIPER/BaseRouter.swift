//
//  BaseRouter.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 20.11.2024.
//

import UIKit

protocol BaseRouterProtocol: AnyObject {
    func createModule() -> UIViewController
}
