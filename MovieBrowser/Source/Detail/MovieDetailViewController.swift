//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var releaseDateLabel: UILabel!
    @IBOutlet weak private var movieImageView: UIImageView!
    @IBOutlet weak private var overViewTextField: UITextView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let title = self.movie?.title,
              let overview = self.movie?.overview,
              let releaseDate = self.movie?.releaseDateShortString else {
            return
        }
        
        self.titleLabel.text = title
        self.releaseDateLabel.text = "Release Date: \(releaseDate)"
        self.overViewTextField.text = overview
        self.movieImageView?.image = UIImage(named: "placeholder")

        if let posterPath = self.movie?.posterPath {
            self.movieImageView?.loadFrom(relativePath: posterPath)
        }
    }
}
