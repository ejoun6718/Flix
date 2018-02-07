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
  
  var movie: [String: Any]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    if let movie = movie {
      titleLabel.text = movie["title"] as? String
      releaseDateLabel.text = movie["release_date"] as? String
      overviewLabel.text = movie["overview"] as? String
      overviewLabel.sizeToFit()
      
      let backdropPathString = movie[MovieKeys.backdropPath] as! String
      let posterPathString = movie[MovieKeys.posterPath] as! String
      let baseURLString = "https://image.tmdb.org/t/p/w500"
      
      let backdropURL = URL(string: baseURLString + backdropPathString)!
      backDropImageView.af_setImage(withURL:backdropURL)
      
      let posterPathURL = URL(string: baseURLString + posterPathString)!
      photoImageView.af_setImage(withURL: posterPathURL)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
