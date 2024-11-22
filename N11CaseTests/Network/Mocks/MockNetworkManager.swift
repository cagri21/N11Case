//
//  MockServiceManager.swift
//  N11Case
//
//  Created by Çağrı Yörükoğlu on 22.11.2024.
//
import NetworkProvider
import Foundation
import Testing
import XCTest
@testable import N11Case
class MockNetworkManager {

    static let sharedInstance: MockNetworkManager = MockNetworkManager()

    func fetchJSON<T: Decodable>(from file: String, as type: T.Type,
                                 completion: @escaping (Swift.Result<T, ExceptionHandler>) -> Void) {
        fetchData(from: file) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    XCTFail("'\(file).json' - decoding error: \(error.localizedDescription)")
                    completion(.failure(ExceptionHandler.invalidFormat))
                }
            case .failure:
                XCTFail("'\(file).json' - fetching data failed")
                completion(.failure(ExceptionHandler.invalidFormat))
            }
        }
    }

    func fetchData(from file: String, completion: @escaping (Swift.Result<Data, ExceptionHandler>) -> Void) {
        guard let jsonURL = Bundle(for: type(of: self)).url(forResource: file, withExtension: "json") else {
            XCTFail("Loading file '\(file).json' failed!")
            completion(.failure(ExceptionHandler.notFound))
            return
        }

        guard let data: Data = try? Data(contentsOf: jsonURL) else {
            XCTFail("Unwrapping data file '\(file).json' failed!")
            completion(.failure(ExceptionHandler.unwrappingError))
            return
        }

        completion(.success(data))
    }

}
