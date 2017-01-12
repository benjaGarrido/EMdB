//
//  LocalCoreDataService.swift
//  EMDb
//
//  Created by Benjamín Garrido Barreiro on 12/1/17.
//  Copyright © 2017 Benjamín Garrido Barreiro. All rights reserved.
//

import Foundation
import CoreData

class LocalCoreDataService {
    let remoteMovieService = RemoteiTunesMovieService()
    let stack = CoreDataStack.sharedInstance
    
    func searchMovies(byTerm: String, remoteHandler: @escaping ([Movie]?) -> Void) {
        remoteMovieService.searchMovies(byTerm: byTerm) { movies in
            if let movies = movies {
                var modelMovies = [Movie]()
                for movie in movies {
                    let modelMovie = Movie(id: movie["id"], title: movie["title"], order: nil, summary: movie["summary"], image: movie["image"], category: movie["category"], director: movie["director"])
                    modelMovies.append(modelMovie)
                }
                remoteHandler(modelMovies)
            } else {
                print("Error while calling REST services")
                remoteHandler(nil)
            }
        }
    }
    
    func getTopMovies(localHandler: ([Movie]?) -> Void, remoteHandler: ([Movie]?) -> Void){
        localHandler(self.queryTopMovies())
        
        remoteMovieService.getTopMovies() { movies in
            if let movies = movies {
                self.markAllMoviesAsUnsync()
                
                var order = 1
                
                for movieDictionary in movies {
                    if let movie = self.getMovieById(id: movieDictionary["id"]!, favorite: false) {
                        // update
                    } else {
                        // insert
                        
                    }
                }
            } else {
                remoteHandler(nil)
            }
        }
    }
    
    func queryTopMovies () -> [Movie]? {
        let context = stack.persistentContainer.viewContext
        let request: NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "order", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        let predicate = NSPredicate(format: "favorite = \(false)")
        request.predicate = predicate
        
        do {
            let fetchedMovies = try context.fetch(request)
            
            var movies = [Movie]()
            for managedMovie in fetchedMovies {
                movies.append(managedMovie.mappedObject())
            }
            return movies
        } catch {
            print("Error while getting movies from Core Data")
            return nil
        }
    }
    
    func markAllMoviesAsUnsync() {
        let context = stack.persistentContainer.viewContext
        let request: NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
        
        let predicate = NSPredicate(format: "favorite = \(false)")
        request.predicate = predicate
        
        do {
            let fetchedMovies = try context.fetch(request)
            for managedMovie in fetchedMovies {
                managedMovie.sync = false
            }
             try context.save()
        } catch {
            print("Error while upodating movies from Core Data")
        }
    }
    
    func getMovieById(id: String, favorite: Bool) -> MovieManaged? {
        let context = stack.persistentContainer.viewContext
        let request: NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
        
        let predicate = NSPredicate(format: "id = \(id) and favorite =\(favorite)")
        request.predicate = predicate
        
        do {
            let fetchedMovies = try context.fetch(request)
            if fetchedMovies.count>0 {
                return fetchedMovies.last
            } else {
                return nil
            }
        } catch {
            print("Error while getting movie from Core Data")
            return nil
        }
    }
}