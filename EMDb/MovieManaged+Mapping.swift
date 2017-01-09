//
//  MovieManaged+Mapping.swift
//  EMDb
//
//  Created by Benjamín Garrido Barreiro on 9/1/17.
//  Copyright © 2017 Benjamín Garrido Barreiro. All rights reserved.
//

import Foundation

extension MovieManaged {
    
    func mappedObject() ->Movie {
        return Movie(id: self.id, title: self.title, order: Int(self.order), summary: self.summary, image: self.image, category: self.category, director: self.director)
    }
}
