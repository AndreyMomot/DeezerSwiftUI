//
//  ArtistViewModel.swift
//  DeezerSwiftUI
//
//  Created by Andrii Momot on 17.05.2022.
//

import Combine
import SwiftUI

final class ArtistViewModel: ObservableObject {
    @Published var dataSource: [AlbumRowViewModel]?
    
    let artist: ArtistsResponse.Artist
    private let api: API
    private var disposables = Set<AnyCancellable>()
    
    init(artist: ArtistsResponse.Artist, api: API) {
        self.artist = artist
        self.api = api
    }
    
    func getAlbums() {
        let request = AlbumsRequest(artistID: artist.id)
        api.send(request)
            .map { response -> [AlbumRowViewModel]? in
                return response.data.map { item in
                    var item = item
                    item.artist = self.artist
                    return AlbumRowViewModel(item: item)
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
                    self.dataSource = response
                })
            .store(in: &disposables)
    }
}

extension ArtistViewModel {
    @ViewBuilder
    func makeAlbumView(with album: AlbumsResponse.Album) -> some View {
        AlbumBuilder.makeAlbumView(
            withAlbum: album,
            api: api)
    }
}
