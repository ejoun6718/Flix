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
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 50
    }
  }
  
  var movies: [Movie] = []
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
    MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
      if let movies = movies {
        self.movies = movies
        self.tableView.reloadData()
      }
    }
    self.refreshControl.endRefreshing()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
    
    cell.movie = movies[indexPath.row]
    
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


