//
//  Movie.swift
//  Flix
//
//  Created by Hye Lim Joun on 2/28/18.
//  Copyright © 2018 hyelim. All rights reserved.
//

import Foundation

class Movie {
  var title: String
  var overview: String
  var posterUrl: URL?
  var releaseDate: String?
  var backdropPath: String?
  
  init(dictionary: [String: Any]) {
    title = dictionary["title"] as? String ?? "No title"
    overview = dictionary["overview"] as? String ?? "No description"
    releaseDate = dictionary["release_date"] as? String ?? "Unknown release date"
    backdropPath = dictionary[MovieKeys.backdropPath] as? String
    
    if let posterPathString = dictionary["poster_path"] as? String {
      let baseURLString = "https://image.tmdb.org/t/p/w500"
      posterUrl = URL(string: baseURLString + posterPathString)!
    }
  }
  
  class func movies(dictionaries: [[String: Any]]) -> [Movie] {
    var movies: [Movie] = []
    for dictionary in dictionaries {
      let movie = Movie(dictionary: dictionary)
      movies.append(movie)
    }
    
    return movies
  }
}
