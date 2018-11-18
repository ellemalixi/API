//
//  MainViewController.swift
//  MovieAPICall
//
//  Created by Michelle M on 18/11/2018.
//  Copyright © 2018 batgirl. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dataTable: UITableView!
    static let mainViewNibName = "MainViewController"

    var dataArray: [MoviesFormatted] = [MoviesFormatted]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // basically creates/registers cell on table
        self.dataTable.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
         self.dataTable.rowHeight = 270
        
        makeAPICall()
    }
    
    //MARK: - API Call
    
    func makeAPICall() {
        let url: String = "https://www.omdbapi.com/?s=harry&apikey=85de34bb"
        Alamofire.request(url) .responseData { response in
            
            let jsonData = response.data
            if let notNildata = jsonData {
                // decodes JSON
                let tempData = try! JSONDecoder().decode(MoviesMain.self, from: notNildata)
                
                if let movieList = tempData.Search {
                    for movie in movieList {
                        // initialize movieFormatted
                        var movieFormatted: MoviesFormatted = MoviesFormatted(title: "", year: "", imdbID: "", movieType: "", poster: "")
                        
                        movieFormatted.title = movie?.Title ?? ""
                        movieFormatted.year = movie?.Year ?? ""
                        movieFormatted.movieType = movie?.movieType ?? ""
                        movieFormatted.poster = movie?.Poster ?? ""
                        movieFormatted.imdbID = movie?.imdbID ?? ""
                        
                        self.dataArray.append(movieFormatted)
                    }
                    
                    // reloads rows and sections in table view
                    self.dataTable.reloadData()
                }
            }
            //print("debug count: \(self.dataArray.count)")
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tempMovieFormatted: MoviesFormatted = self.dataArray[indexPath.row] // getting position or row
        
        // basically gets before and after cells / reuses cells
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        
        cell.configure(moviesFormatted: tempMovieFormatted)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
//    func tableView(_ didSelectRowAttableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
}

