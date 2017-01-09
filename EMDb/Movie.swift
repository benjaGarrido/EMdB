//
//  Movie.swift
//  EMDb
//
//  Created by Benjamín Garrido Barreiro on 9/1/17.
//  Copyright © 2017 Benjamín Garrido Barreiro. All rights reserved.
//

import Foundation

class Movie {
    let id: String?
    let title: String?
    let order: Int?
    let summary: String?
    let image: String?
    let category: String?
    let director: String?
    
    init(id: String?, title: String?, order: Int?, summary: String?, image: String?, category: String?, director: String?) {
        self.id = id
        self.title = title
        self.order = order
        self.summary = summary
        self.image = image
        self.category = category
        self.director = director
    }
}
