//
//  ImageManager.swift
//  ExPrefetch
//
//  Created by 김종권 on 2024/03/24.
//

import SDWebImage

enum ImageManager {
    private static let Prefetcher = SDWebImagePrefetcher.shared
    private static let Downloader = SDWebImageDownloader.shared
    
    static func prefetch(urls: [URL], completion: @escaping () -> Void) {
        Prefetcher.prefetchURLs(urls, progress: nil) { successedCount, skippedCount in
            completion()
        }
    }
    
    static func downloadData(url: URL, completion: @escaping (Data) -> Void) {
        Downloader.downloadImage(with: url, options: [], progress: nil) { (image, data, error, finished) in
            if let data = data, finished {
                completion(data)
            } else if let error = error {
                print("이미지 다운로드 실패 URL \(url): \(error.localizedDescription)")
            }
        }
    }
    
    static func downloadDatas(urls: [URL], completion: @escaping ([Data]) -> Void) {
        let group = DispatchGroup()
        var imagesData = [Data]()
        
        urls.forEach { url in
            // 1
            print("enter")
            group.enter()
            
            downloadData(url: url, completion: { data in
                imagesData.append(data)
                // 2
                print("leave")
                group.leave()
            })
        }
        
        group.notify(queue: .main) {
            print("다운 완료:", imagesData.count)
            completion(imagesData)
        }
    }
}
