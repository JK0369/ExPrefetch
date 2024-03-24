//
//  ViewController.swift
//  ExPrefetch
//
//  Created by 김종권 on 2024/03/24.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, SDWebImageManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urls = [
            "https://cdn.pixabay.com/photo/2016/02/21/06/22/macbook-air-1213180_1280.jpg",
            "https://cdn.pixabay.com/photo/2019/02/04/06/46/apple-3974057_1280.jpg",
            "https://cdn.pixabay.com/photo/2018/07/09/18/17/apple-3526737_1280.jpg",
            "https://images.pexels.com/photos/4246192/pexels-photo-4246192.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
        ].compactMap(URL.init(string:))
        
        ImageManager.downloadDatas(urls: urls) { datas in
            print("res:", datas)
        }
    }
}
