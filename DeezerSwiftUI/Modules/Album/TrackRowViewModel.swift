//
//  TrackRowViewModel.swift
//  DeezerSwiftUI
//
//  Created by Andrii Momot on 17.05.2022.
//

import Foundation
import SwiftUI

struct TrackRowViewModel: Identifiable {
    var item: TracksResponse.Track
    var index: Int
    
    init(item: TracksResponse.Track, index: Int) {
        self.item = item
        self.index = index
    }
    
    var id: Int {
        return item.id
    }
    
    var durationTime: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        let duration = formatter.string(from: TimeInterval(item.duration))
        return duration
    }
}
