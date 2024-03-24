//
//  ImageManagerRx.swift
//  ExPrefetch
//
//  Created by 김종권 on 2024/03/24.
//

import SDWebImage
import RxSwift
import RxCocoa

enum ImageManagerRx {
    private static let Downloader = SDWebImageDownloader.shared
    
    static func downloadData(url: URL) -> Single<Data> {
        .create { observer in
            Downloader.downloadImage(with: url) { image, data, error, finished in
                if let error {
                    observer(.failure(error))
                } else if let data {
                    observer(.success(data))
                } else {
                    observer(.failure(NSError()))
                }
            }
            return Disposables.create()
        }
    }
    
    static func downloadDatas(urls: [URL]) -> Single<[Data]> {
        let observables = urls.map { downloadData(url: $0) }
        return Single.zip(observables)
    }
}
