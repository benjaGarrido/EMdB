//
//  MovieViewController.swift
//  EMDb
//
//  Created by Benjamín Garrido Barreiro on 12/1/17.
//  Copyright © 2017 Benjamín Garrido Barreiro. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var btnFavorite : UIButton!
    @IBOutlet weak var movieImage : UIImageView!
    @IBOutlet weak var movieSummary : UITextView!
    @IBOutlet weak var movieTitle : UILabel!
    @IBOutlet weak var movieCategory : UILabel!
    @IBOutlet weak var movieDirector : UILabel!
    
    var dataProvider = LocalCoreDataService()
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func configureFavoriteButton() {
        if let movie = self.movie {
            if dataProvider.isMovieFavorite(movie: movie) {
                btnFavorite.setBackgroundImage(#imageLiteral(resourceName: "btn-on"), for: .normal)
                btnFavorite.setTitle("Quiero verla!", for: .normal)
            } else {
                btnFavorite.setBackgroundImage(#imageLiteral(resourceName: "btn-off"), for: .normal)
                btnFavorite.setTitle("No me interesa!", for: .normal)
            }
        }
    }
    @IBAction func favoritePressed(_ sender: UIButton) {
        if let movie = self.movie {
            dataProvider.markUnmarkFavorite(movie: movie)
        }
    }
}
