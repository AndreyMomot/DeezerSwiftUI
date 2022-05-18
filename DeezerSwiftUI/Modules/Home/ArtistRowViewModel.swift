//
//  ArtistRowViewModel.swift
//  DeezerSwiftUI
//
//  Created by Andrii Momot on 17.05.2022.
//

import Foundation
import SwiftUI

struct ArtistRowViewModel: Identifiable {
    let item: ArtistsResponse.Artist
    
    init(item: ArtistsResponse.Artist) {
      self.item = item
    }
    
    var id: Int {
        return item.id
    }
}
