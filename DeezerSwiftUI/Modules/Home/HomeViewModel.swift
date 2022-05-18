//
//  HomeViewModel.swift
//  DeezerSwiftUI
//
//  Created by Andrii Momot on 17.05.2022.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var dataSource: [ArtistRowViewModel] = []
    
    private let api: API
    private var disposables = Set<AnyCancellable>()
    
    init(
        api: API,
        scheduler: DispatchQueue = DispatchQueue(label: "HomeViewModel")
    ) {
        self.api = api
        $searchText
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: search(forArtist:))
            .store(in: &disposables)
    }
    
    func search(forArtist: String) {
        let request = SearchRequest(artist: searchText)
        api.send(request)
            .map { response in
                response.data.map(ArtistRowViewModel.init)
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

extension HomeViewModel {
    @ViewBuilder
    func makeArtistView(with artist: ArtistsResponse.Artist) -> some View {
        ArtistBuilder.makeArtistView(
            withArtist: artist,
            api: api)
    }
}
