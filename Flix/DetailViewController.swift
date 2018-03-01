//
//  DetailViewController.swift
//  Flix
//
//  Created by Hye Lim Joun on 2/3/18.
//  Copyright © 2018 hyelim. All rights reserved.
//

import UIKit

enum MovieKeys {
  static let title = "title"
  static let backdropPath = "backdrop_path"
  static let posterPath = "poster_path"
}

class DetailViewController: UIViewController {
  
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  @IBOutlet weak var backDropImageView: UIImageView!
  @IBOutlet weak var releaseDateLabel: UILabel!
  
  var movie: Movie?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    if let movie = movie {
      titleLabel.text = movie.title
      releaseDateLabel.text = movie.releaseDate
      overviewLabel.text = movie.overview
      
      let backdropPathString = movie.backdropPath
      let baseURLString = "https://image.tmdb.org/t/p/w500"
      
      let backdropURL = URL(string: baseURLString + backdropPathString!)!
      backDropImageView.af_setImage(withURL:backdropURL)
      
      if movie.posterUrl != nil {
        photoImageView.af_setImage(withURL: movie.posterUrl!)
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
