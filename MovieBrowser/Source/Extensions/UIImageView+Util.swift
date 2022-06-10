//
//  UIImage+Util.swift
//  MovieBrowser
//
//  Created by Keith Dougherty on 6/8/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadFrom(relativePath: String) {
   
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/") else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url.appendingPathComponent(relativePath)) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
