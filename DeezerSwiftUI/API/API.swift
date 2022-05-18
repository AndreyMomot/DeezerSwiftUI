//
//  API.swift
//  DeezerSwiftUI
//
//  Created by Andrii Momot on 17.05.2022.
//

import Foundation
import Combine

protocol API {
    func send<T>(_ request: T) -> AnyPublisher<T.Response, APIError> where T: APIRequest
}
