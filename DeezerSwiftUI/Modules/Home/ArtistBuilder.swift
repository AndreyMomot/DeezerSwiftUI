//
//  ArtistBuilder.swift
//  DeezerSwiftUI
//
//  Created by Andrii Momot on 17.05.2022.
//

import SwiftUI

enum ArtistBuilder {
  static func makeArtistView(
    withArtist artist: ArtistsResponse.Artist,
    api: API
  ) -> some View {
      let viewModel = ArtistViewModel(
        artist: artist,
        api: api)
    return ArtistView(viewModel: viewModel)
  }
}
