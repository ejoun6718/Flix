//
//  DetailViewController.swift
//  Flix
//
//  Created by Hye Lim Joun on 2/3/18.
//  Copyright © 2018 hyelim. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  var movie: [String: Any]?
  
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    titleLabel.text = movie!["title"] as? String
    overviewLabel.text = movie!["overview"] as? String
    overviewLabel.sizeToFit()
    if let posterPathString = movie!["poster_path"] as? String {
      let baseURLString = "https://image.tmdb.org/t/p/w500"
      let posterURL = URL(string: baseURLString + posterPathString)!
      photoImageView.af_setImage(withURL: posterURL)
    }
    else {
      photoImageView.image = nil
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
