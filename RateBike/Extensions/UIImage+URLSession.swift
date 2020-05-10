//
//  UIImage+SDWebImage.swift
//  RateBike
//
//  Created by Сергей Вихляев on 06.05.2020.
//  Copyright © 2020 Сергей Вихляев. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func setImage(from url: URL, completion: @escaping (UIImage?, Error?)->()) {
        UIImage.getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                let image = UIImage(data: data)
                completion(image, nil)
            }
        }
    }
    
    class func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
