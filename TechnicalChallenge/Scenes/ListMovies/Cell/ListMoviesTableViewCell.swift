//
//  ListMoviesTableViewCell.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 28/01/24.
//

import UIKit
import Kingfisher

class ListMoviesTableViewCell: UITableViewCell {
    @IBOutlet weak var movieCellImage: UIImageView!
    @IBOutlet weak var movieTitleCellLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension ListMoviesTableViewCell {
    func setupCell(movie: ListMoviesModel?) {
        movieTitleCellLabel.text = movie?.title ?? ""
        if let url = URL(string: Constants.UrlConstants.imageUrl + (movie?.poster_path ?? "")) {
            movieCellImage.kf.setImage(with: url, options: [.transition(.fade(0.5))])
        }
    }
}
