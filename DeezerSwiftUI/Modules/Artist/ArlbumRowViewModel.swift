//
//  AlbumRowViewModel.swift
//  DeezerSwiftUI
//
//  Created by Andrii Momot on 17.05.2022.
//

import Foundation
import SwiftUI

struct AlbumRowViewModel: Identifiable {
    let item: AlbumsResponse.Album
    
    init(item: AlbumsResponse.Album) {
      self.item = item
    }
    
    var id: Int {
        return item.id
    }
}
