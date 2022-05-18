//
//  ArtistView.swift
//  DeezerSwiftUI
//
//  Created by Andrii Momot on 17.05.2022.
//

import SwiftUI

struct ArtistView: View {
    @ObservedObject var viewModel: ArtistViewModel
    
    init(viewModel: ArtistViewModel) {
        self.viewModel = viewModel
    }
    
    var columns: [GridItem] {
        Array(repeating: .init(.flexible()), count: 2)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if let dataSource = viewModel.dataSource {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(dataSource, id: \.id) { response in
                        NavigationLink(destination: viewModel.makeAlbumView(with: response.item)) {
                            details(for: response)
                        }
                    }
                }
            } else {
                AnyView(loading)
            }
        }
        .onAppear(perform: viewModel.getAlbums)
        .navigationBarTitle("\(viewModel.artist.name)")
    }
}

private extension ArtistView {
    
    func details(for viewModel: AlbumRowViewModel) -> some View {
        AlbumRow(viewModel: viewModel)
    }
    
    var loading: some View {
        Text("Loading \(viewModel.artist.name)'s albums...")
            .foregroundColor(.gray)
    }
}
