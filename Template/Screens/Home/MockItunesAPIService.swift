//
//  MockItunesAPIService.swift
//  Template
//
//  Created by Apple on 07/03/22.
//

import Foundation

enum APIServiceError : Error {
    case searchTextEmpty
}

extension APIServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .searchTextEmpty:
            return NSLocalizedString(
                "Search text can not be empty",
                comment: ""
            )
        }
    }
}

struct MockItunesAPIService: ItunesApiServiceProtocol {
    func getSongs(for text: String, completion: @escaping (Result<ItunesResultModel?, Error>) -> Void) {
        if (text.isEmpty) {
            completion(.failure(APIServiceError.searchTextEmpty))
        } else {
            let songModel = SongModel(wrapperType: .track, kind: .song, artistID: 70936, collectionID: 1440811207, trackID: 1440811252, artistName: "Johnny Cash", collectionName: "American IV: The Man Comes Around", trackName: "Hurt", collectionCensoredName: "American IV: The Man Comes Around", trackCensoredName: "Hurt", artistViewURL: "https://music.apple.com/us/artist/johnny-cash/70936?uo=4", collectionViewURL: "https://music.apple.com/us/album/hurt/1440811207?i=1440811252&uo=4", trackViewURL: "https://music.apple.com/us/album/hurt/1440811207?i=1440811252&uo=4", previewURL: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/2f/42/a3/2f42a349-280a-0cc7-b407-f12a2b80578b/mzaf_11428832796877434996.plus.aac.p.m4a", artworkUrl30: "https://is4-ssl.mzstatic.com/image/thumb/Music124/v4/36/08/4d/36084d81-ac5b-2996-9cce-d59b1b7d7647/source/30x30bb.jpg", artworkUrl60: "https://is4-ssl.mzstatic.com/image/thumb/Music124/v4/36/08/4d/36084d81-ac5b-2996-9cce-d59b1b7d7647/source/60x60bb.jpg", artworkUrl100: "https://is4-ssl.mzstatic.com/image/thumb/Music124/v4/36/08/4d/36084d81-ac5b-2996-9cce-d59b1b7d7647/source/100x100bb.jpg", collectionPrice: 9.99, trackPrice: 1.29, releaseDate: "2002-11-04T12:00:00Z", collectionExplicitness: .notExplicit, trackExplicitness: .notExplicit, discCount: 1, discNumber: 1, trackCount: 15, trackNumber: 2, trackTimeMillis: 216533, country: .usa, currency: .usd, primaryGenreName: "Country", isStreamable: true, collectionArtistID: nil, collectionArtistName: nil, contentAdvisoryRating: nil, collectionArtistViewURL: nil)
            
            let itunesResultModel = ItunesResultModel(resultCount: 1, results: [songModel])
            completion(.success(itunesResultModel))
        }
        
    }
    
    
}
