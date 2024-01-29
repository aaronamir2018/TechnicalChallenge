//
//  DataManager.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 28/01/24.
//

import Foundation
import CoreData

class DataManager {
    static let shared = DataManager()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.PersistentContainer.retoSoftekMovies)
        container.viewContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func movieCoreData(id: Int64, title: String, original_title: String, overview: String, release_date: String, poster_path: String, vote_average: Double) -> ListMovieEntity {
        let movie = ListMovieEntity(context: persistentContainer.viewContext)
        movie.id = id
        movie.title = title
        movie.original_title = original_title
        movie.overview = overview
        movie.release_date = release_date
        movie.poster_path = poster_path
        movie.vote_average = vote_average
        return movie
    }

    func moviesCore() -> [ListMovieEntity] {
        let request: NSFetchRequest<ListMovieEntity> = ListMovieEntity.fetchRequest()
        var fetchedMovies: [ListMovieEntity] = []
        do {
            fetchedMovies = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("ErrorMovies")
        }

        return fetchedMovies
    }

    func saveMovies() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
