//
//  ViewController.swift
//  EMDb
//
//  Created by Benjamín Garrido Barreiro on 9/1/17.
//  Copyright © 2017 Benjamín Garrido Barreiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let remote = RemoteiTunesMovieService()
        remote.getTopMovies { result in
            if let result = result {
                print(result.count)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

