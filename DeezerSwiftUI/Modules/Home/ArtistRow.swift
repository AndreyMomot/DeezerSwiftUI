//
//  ArtistRow.swift
//  DeezerSwiftUI
//
//  Created by Andrii Momot on 17.05.2022.
//

import SwiftUI

struct ArtistRow: View {
  private let viewModel: ArtistRowViewModel
  
  init(viewModel: ArtistRowViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    HStack {
        if let imageUrl = viewModel.item.picture {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image.resizable()
                     .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
        }
        Text("\(viewModel.item.name)")
            .font(.title)
    }.frame(height: 44)
  }
}
