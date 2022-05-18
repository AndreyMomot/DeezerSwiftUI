//
//  AlbumViewModel.swift
//  DeezerSwiftUI
//
//  Created by Andrii Momot on 17.05.2022.
//

import Combine
import SwiftUI

final class AlbumViewModel: ObservableObject {
    @Published var dataSource: [TrackRowViewModel] = []
    
    let album: AlbumsResponse.Album
    private let api: API
    private var disposables = Set<AnyCancellable>()
    
    init(album: AlbumsResponse.Album, api: API) {
        self.album = album
        self.api = api
    }
    
    func getAlbumInfo() {
        let request = AlbumInfoRequest(albumID: album.id)
        api.send(request)
//            .indices.forEach({ item in
//                return TrackRowViewModel(item: item)
//            })
            .map { response -> [TrackRowViewModel]? in
                return response.tracks?.data.map { item in
                    return TrackRowViewModel(item: item)
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.dataSource = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    self.dataSource = response ?? []
                })
            .store(in: &disposables)
    }
}
