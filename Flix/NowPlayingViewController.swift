//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Hye Lim Joun on 1/29/18.
//  Copyright © 2018 hyelim. All rights reserved.
//

import UIKit
import AlamofireImage
import KRProgressHUD

class NowPlayingViewController: UIViewController, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      self.tableView.rowHeight = 150
    }
  }
  
  var movies: [[String: Any]] = []
  var refreshControl: UIRefreshControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    KRProgressHUD
      .set(style: .custom(background: .black, text: .white, icon: nil))
      .set(maskType: .white)
    
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector (NowPlayingViewController.didPullToRefresh(_:)), for: . valueChanged)
    tableView.insertSubview(refreshControl, at: 0)
    
    tableView.dataSource = self
    fetchMovies()
  }
  
  @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
    KRProgressHUD.show()
    
    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
      KRProgressHUD.dismiss()
    }
    fetchMovies()
  }
  
  func fetchMovies() {
    let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
    let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    let task = session.dataTask(with: request) { (data, response, error) in
      // This will run when the network request returns
      if let error = error {
        print(error.localizedDescription)
      } else if let data = data {
        let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        let movies = dataDictionary["results"] as! [[String: Any]]
        self.movies = movies
        // Wait for network request
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
      }
    }
    task.resume()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
    
    // No color when the user selects cell
    cell.selectionStyle = .none
    
    let movie = movies[indexPath.row]
    let title = movie["title"] as! String
    let overview = movie["overview"] as! String
    
    cell.titleLabel.text = title
    cell.overviewLabel.text = overview
    cell.overviewLabel.sizeToFit()
    
    if let posterPathString = movie["poster_path"] as? String {
      let baseURLString = "https://image.tmdb.org/t/p/w500"
      let posterURL = URL(string: baseURLString + posterPathString)!
      cell.posterImageView.af_setImage(withURL: posterURL)
    }
    else {
      cell.posterImageView.image = nil
    }
    return cell
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let cell = sender as! UITableViewCell
    // Get the index path from the cell that was tapped
    if let indexPath = tableView.indexPath(for: cell) {
        let movie = movies[indexPath.row]
        let detailViewController = segue.destination as! DetailViewController
        // Pass on the data to the Detail ViewController
        detailViewController.movie = movie
    }
  }
}


