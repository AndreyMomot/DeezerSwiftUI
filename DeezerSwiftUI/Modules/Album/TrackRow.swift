//
//  TrackRow.swift
//  DeezerSwiftUI
//
//  Created by Andrii Momot on 17.05.2022.
//

import SwiftUI

struct TrackRow: View {
    private let viewModel: TrackRowViewModel
  
  init(viewModel: TrackRowViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    HStack {
        
        if let index = viewModel.item.index {
            Text("\(index)")
                .font(.largeTitle)
        }
        
        VStack {
            Text("\(viewModel.item.title)")
                .font(.body)
            if let name = viewModel.item.artist?.name {
                Text("\(name)")
                    .font(.body)
            }
        }
        
        Spacer()
        
        if let duration = viewModel.durationTime {
            Text("\(duration)")
                .font(.body)
        }
    }.frame(height: 60)
  }
}
