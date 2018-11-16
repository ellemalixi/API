//
//  ViewController.swift
//  APICall
//
//  Created by Michelle Malixi on 11/16/18.
//  Copyright © 2018 Michelle Malixi. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var mainView: MainView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = Bundle.main.loadNibNamed("MainView", owner: self, options: nil)![0] as! UIView as? MainView
        mainView.frame = self.view.bounds
        self.view.addSubview(mainView)
        
        // To call API
        makeAPICall()
    }
    
    func makeAPICall() {
        let url: String = "http://www.omdbapi.com/?i=tt3896198&apikey=85de34bb"
        Alamofire.request(url)
            .responseJSON {
                response in
                
                guard response.result.error == nil else {
                    // if there's error, need to handle it
                    print("error calling GET on api")
                    print(response.result.error!)
                    return
                }
                
                // Making sure I received some JSON
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get obj as JSON from API")
                    
                    if let error = response.result.error {
                        print("Error: \(error)")
                    }
                    return
                }
                
                // Get & print Movie title
                guard let movieTitle = json["Title"] as? String else {
                    print("Couldn't get title from JSON")
                    return
                }
                // print("Title is \(movieTitle)")
                self.mainView.title.text = movieTitle
                
                guard let image = json["Poster"] as? String else {
                    print("Couldn't get pic from JSON")
                    return
                }
                
                let imageUrl = URL(string: image)!
                
                let imageData = try! Data(contentsOf: imageUrl)
                
                let finalImg = UIImage(data: imageData)
                
                // print("image url: \(image)")
                self.mainView.image.image = finalImg!
                
                guard let rating = json["imdbRating"] as? String else {
                    print("Couldn't get rating from JSON")
                    return
                }
                self.mainView.rating.text = "Rating: \(rating) / 10"
                //self.mainView.title.text ? movieTitle : ""
                //print("rating: \(rating)")
            }
    }

}

