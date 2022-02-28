//
//  ListMoviesInteractor.swift
//  MandiriTechnicalTest
//
//  Created by Vincent on 25/02/22.
//

import Foundation

class ListMoviesInteractor{
    
    //FETCH ALL GENRE
    static func fetchAPIGenre(url: String, completion: @escaping (Genres) -> Void){
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil{
                print(error?.localizedDescription)
            }
            
            var result: Genres?
            
            do{
                result = try JSONDecoder().decode(Genres.self, from: data!)
            }catch{
                print(error.localizedDescription)
            }
            
            guard let api = result else { return }
            completion(api)
        }
        dataTask.resume()
    }
    
    //FETCH MOVIE ACCORDING TO GENRE
    static func fetchAPIMovieList(page: Int, genre: Int, completion: @escaping (Movies) -> Void){
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/discover/movie?api_key=d7ff494718186ed94ee75cf73c1a3214&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=true&page=\(page)&with_genres=\(genre)&with_watch_monetization_types=flatrate")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil{
                print(error?.localizedDescription)
            }
            
            var result: Movies?
            
            do{
                result = try JSONDecoder().decode(Movies.self, from: data!)
            }catch{
                print(error.localizedDescription)
            }
            
            guard let api = result else { return }
            completion(api)
        }
        dataTask.resume()
    }
    
    //FETCH MOVIE DETAILS
    static func fetchAPIMovieDetail(id: Int, completion: @escaping (MovieDetails) -> Void){
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=d7ff494718186ed94ee75cf73c1a3214&language=en-US")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil{
                print(error?.localizedDescription)
            }
            
            var result: MovieDetails?
            
            do{
                result = try JSONDecoder().decode(MovieDetails.self, from: data!)
            }catch{
                print(error.localizedDescription)
            }
            
            guard let api = result else { return }
            completion(api)
        }
        dataTask.resume()
    }
    
    //FETCH USER REVIEW IN MOVIE DETAILS
    static func fetchAPIUserReview(page: Int, id: Int, completion: @escaping (Reviews) -> Void){
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/\(id)/reviews?api_key=d7ff494718186ed94ee75cf73c1a3214&language=en-US&page=\(page)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil{
                print(error?.localizedDescription)
            }
            
            var result: Reviews?
            
            do{
                result = try JSONDecoder().decode(Reviews.self, from: data!)
            }catch{
                print(error.localizedDescription)
            }
            
            guard let api = result else { return }
            completion(api)
        }
        dataTask.resume()
    }
    
    //GET YOUTUBE VIDEO KEY
    static func fetchAPIMovieVideo(id: Int, completion: @escaping (MovieVideos) -> Void){
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=d7ff494718186ed94ee75cf73c1a3214&language=en-US")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil{
                print(error?.localizedDescription)
            }
            
            var result: MovieVideos?
            
            do{
                result = try JSONDecoder().decode(MovieVideos.self, from: data!)
            }catch{
                print(error.localizedDescription)
            }
            
            guard let api = result else { return }
            completion(api)
        }
        dataTask.resume()
    }
}
