//
//  SearchResultsViewModel.swift
//  TableView
//
//  Created by Basharat on 24/06/22.
//

import Foundation
import Combine
import SwiftUI

final class MovieViewModel: ObservableObject {
    
    init(){
    }
    
    
    public func getMovieData(completion: @escaping(Result<MovieResponseModel?, Error>) ->()){
        Webservice().getMovieData{ result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    public func getMovieDetailsData(id: String, completion: @escaping(Result<MovieDetailsResponseModel?, Error>) ->()) {
        Webservice().getMovieDetailsData(id: id){ result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
}

