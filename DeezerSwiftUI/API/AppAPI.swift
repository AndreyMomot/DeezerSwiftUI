//
//  AppAPI.swift
//  DeezerSwiftUI
//
//  Created by Andrii Momot on 17.05.2022.
//

import Foundation
import Combine

class AppAPI: API {
    
    func send<T>(_ request: T) -> AnyPublisher<T.Response, APIError> where T: APIRequest {
        guard let path = "https://api.deezer.com/\(request.path)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            let error = APIError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        var components = URLComponents(string: path)
        if let parameters = request.parameters() as? [String: Any] {
            components?.queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: String(describing: value))
            }
        }
        
        guard let url = components?.url else {
            let error = APIError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
          .mapError { error in
            .network(description: error.localizedDescription)
          }
          .flatMap(maxPublishers: .max(1)) { pair in
            decode(pair.data)
          }
          .eraseToAnyPublisher()
    }
}

