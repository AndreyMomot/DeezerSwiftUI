//
//  AlbumBuilder.swift
//  DeezerSwiftUI
//
//  Created by Andrii Momot on 17.05.2022.
//

import SwiftUI

enum AlbumBuilder {
  static func makeAlbumView(
    withAlbum album: AlbumsResponse.Album,
    api: API
  ) -> some View {
      let viewModel = AlbumViewModel(
        album: album,
        api: api)
    return AlbumView(viewModel: viewModel)
  }
}
