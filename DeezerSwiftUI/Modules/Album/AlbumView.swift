//
//  AlbumView.swift
//  DeezerSwiftUI
//
//  Created by Andrii Momot on 17.05.2022.
//

import SwiftUI

struct AlbumView: View {
    @ObservedObject var viewModel: AlbumViewModel
    
    init(viewModel: AlbumViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                if let imageUrl = viewModel.album.bigCover {
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image.resizable()
                             .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                }
                albumSection
            }
            .listStyle(GroupedListStyle())
        }
        .onAppear(perform: viewModel.getAlbumInfo)
        .navigationBarTitle("\(viewModel.album.title)")
    }
}

private extension AlbumView {

    
    var albumSection: some View {
        Section {
            ForEach(viewModel.dataSource) { response in
                VStack(alignment: .leading) {
                    TrackRow(viewModel: response)
                }
            }
        }
    }
}
