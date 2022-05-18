//
//  AlbumRow.swift
//  DeezerSwiftUI
//
//  Created by Andrii Momot on 17.05.2022.
//

import SwiftUI

struct AlbumRow: View {
  private let viewModel: AlbumRowViewModel
  
  init(viewModel: AlbumRowViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
        if let imageUrl = viewModel.item.cover {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image.resizable()
                     .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }.cornerRadius(10)
        }
        Text("\(viewModel.item.title)")
            .font(.body)
        if let name = viewModel.item.artist?.name {
            Text("\(name)")
                .font(.body)
        }
    }.frame(height: 200)
  }
}
