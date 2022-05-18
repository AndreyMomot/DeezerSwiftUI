//
//  APIError.swift
//  DeezerSwiftUI
//
//  Created by Andrii Momot on 17.05.2022.
//

enum APIError: Error {
  case parsing(description: String)
  case network(description: String)
}
