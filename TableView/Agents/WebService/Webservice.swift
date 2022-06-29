//
//  Webservice.swift
//  TableView
//
//  Created by Basharat on 24/06/22.
//

import Foundation
import CoreLocation
import SwiftUI
import Combine

class Webservice
{
    
    func getMovieData(completion: @escaping(Result<MovieResponseModel?, Error>) ->()){
        var components = URLComponents()
            components.scheme = "https"
        components.host = Constants.baseUrl
        components.path = Constants.popularMovies
            components.queryItems = [
                URLQueryItem(name: "api_key", value: Constants.apiKey),
            ]

        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  return }
            do{
                let str = String(decoding: dataResponse, as: UTF8.self)
                print(str)


                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let model:MovieResponseModel = try decoder.decode(MovieResponseModel.self, from:
                                                                            dataResponse) //Decode JSON Response Data
                print(model)
                DispatchQueue.main.async {
                    completion(.success(model))
                }
              
            } catch _ {
                completion(.failure(error as! Error))

           }
        }
        task.resume()
        
    }
    
    func getMovieDetailsData(id: String, completion: @escaping(Result<MovieDetailsResponseModel?, Error>) ->()){
        var components = URLComponents()
            components.scheme = "https"
        components.host = Constants.baseUrl
        components.path = Constants.movieDetails + "/\(id)"
            components.queryItems = [
                URLQueryItem(name: "api_key", value: Constants.apiKey),
            ]

        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 60
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  return }
            do{
                let str = String(decoding: dataResponse, as: UTF8.self)
                print(str)


                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let model:MovieDetailsResponseModel = try decoder.decode(MovieDetailsResponseModel.self, from:
                                                                            dataResponse) //Decode JSON Response Data
                print(model)
                DispatchQueue.main.async {
                    completion(.success(model))
                }
              
            } catch _ {
                completion(.failure(error as! Error))

           }
        }
        task.resume()
        
    }
}

