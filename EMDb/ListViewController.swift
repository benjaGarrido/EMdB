//
//  ListViewController.swift
//  EMDb
//
//  Created by Benjamín Garrido Barreiro on 12/1/17.
//  Copyright © 2017 Benjamín Garrido Barreiro. All rights reserved.
//

import UIKit
import Kingfisher

class ListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    var movies : [Movie] = [Movie]()
    var collectionViewPadding : CGFloat = 0
    var tapGesture : UITapGestureRecognizer!
    
    let refresh = UIRefreshControl()
    let dataProvider = LocalCoreDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func setupCollectionViewPadding() {
        let screenWidth = self.view.frame.width
        collectionViewPadding = (screenWidth - (3 * 113)) / 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(collectionViewPadding, collectionViewPadding, collectionViewPadding, collectionViewPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionViewPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie  = movies[indexPath.row]
        self.configureCell(cell, withMovie: movie)
        
        return cell
    }
    
    func configureCell(_ cell: MovieCell, withMovie movie: Movie) {
        if let imageData = movie.image {
            cell.movieImage.kf.setImage(with: ImageResource(downloadURL: URL(string: imageData)!), placeholder: #imageLiteral(resourceName: "img-loading"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
}
