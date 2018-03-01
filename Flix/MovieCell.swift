//
//  MovieCell.swift
//  Flix
//
//  Created by Hye Lim Joun on 1/30/18.
//  Copyright © 2018 hyelim. All rights reserved.
//

import UIKit

internal class MovieCell : UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  @IBOutlet weak var posterImageView: UIImageView!
  
  var movie: Movie! {
    didSet {
      titleLabel.text = movie.title
      overviewLabel.text = movie.overview
      if movie.posterUrl != nil {
        posterImageView.af_setImage(withURL: movie.posterUrl!)
      }
    }
  }
  
  override internal func awakeFromNib() {
  }
  
  override internal func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}

