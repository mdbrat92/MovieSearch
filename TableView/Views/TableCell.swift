//
//  TableCell.swift
//  TableView
//
//  Created by Basharat on 24/06/22.
//  Copyright (c) 2014 Bilal ARSLAN. All rights reserved.
//

import Foundation
import UIKit

class TableCell: UITableViewCell {

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var prepTimeLabel: UILabel!
    @IBOutlet private var thumbnailImageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        prepTimeLabel.text = nil
        thumbnailImageView.image = nil
    }

    // MARK: Cell Configuration

    func configurateTheCell(_ recipe: ResultObj) {
        nameLabel.text = recipe.title
        prepTimeLabel.text = recipe.releaseDate
        
        let url = URL(string: "\(Constants.baseUrlForImage)\(recipe.posterPath)")

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.thumbnailImageView.image = UIImage(data: data!)
            }
        }
    }

}
