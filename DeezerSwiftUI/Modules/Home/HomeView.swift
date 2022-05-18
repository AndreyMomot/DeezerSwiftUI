//
//  HomeView.swift
//  DeezerSwiftUI
//
//  Created by Andrii Momot on 17.05.2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                searchField
                
                if viewModel.dataSource.isEmpty {
                    emptySection
                } else {
                    artistSection
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Search Deezer")
        }
    }
}

private extension HomeView {
    var searchField: some View {
        HStack(alignment: .center) {
            TextField("e.g. Artbat", text: $viewModel.searchText)
        }
    }
    
    var artistSection: some View {
        Section {
            ForEach(viewModel.dataSource) { response in
                ZStack(alignment: .leading) {
                    NavigationLink(destination: viewModel.makeArtistView(with: response.item)) {
                        EmptyView()
                    }
                    .opacity(0)
                    
                    ArtistRow(viewModel: response)
                }
            }
        }
    }
    
    var emptySection: some View {
        Section {
            Text("No results")
                .foregroundColor(.gray)
        }
    }
}
