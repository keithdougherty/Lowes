//
//  MovieCell.swift
//  MovieBrowser
//
//  Created by Keith Dougherty on 6/9/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell {
 
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieReleaseDate: UILabel!
    @IBOutlet weak var lblMovieRating: UILabel!
    
    var movie: Movie? {
        didSet {
            self.setupData()
        }
    }
    
    func setupData() {
        
        guard let title = movie?.title,
              let releaseDate = movie?.releaseDateLongString,
              let rating = movie?.ratingString else {
            return
        }
        
        self.lblMovieTitle.text = title
        self.lblMovieRating.text = rating
        self.lblMovieReleaseDate.text = releaseDate
    }
}
