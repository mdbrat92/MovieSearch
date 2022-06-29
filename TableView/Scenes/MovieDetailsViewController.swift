//
//  DetailViewController.swift
//  TableView
//
//  Created by Basharat on 24/06/22.
//

import Foundation
import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var prepTime: UILabel!

    var movie: ResultObj?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieDetails()
    }
    
    func fetchMovieDetails(){
        let obj = MovieViewModel()
        
        obj.getMovieDetailsData(id: String(movie?.id ?? 0)){ result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if let resultObj = response {
                        self.navigationItem.title = "Movie Detail"
                        self.nameLabel.text = resultObj.title
                        self.prepTime.text = resultObj.overview
                        
                        if let urlPath = resultObj.posterPath{
                            let url = URL(string: "\(Constants.baseUrlForImage)\(urlPath)")

                            DispatchQueue.global().async {
                                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                DispatchQueue.main.async {
                                    self.imageView.image = UIImage(data: data!)
                                }
                            }
                        }
                        
                        
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
