//
//  DeezerSwiftUIApp.swift
//  DeezerSwiftUI
//
//  Created by Andrii Momot on 16.05.2022.
//

import SwiftUI

@main
struct DeezerSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            let api = AppAPI()
            let viewModel = HomeViewModel(api: api)
            HomeView(viewModel: viewModel)
        }
    }
}
