//
//  UpcomingMovieCell.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 24/01/24.
//

import UIKit

final class UpcomingMovieCell: UITableViewCell {
        
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var averagePointLabel: UILabel!
    @IBOutlet private weak var editButton: UIButton!
        
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.cancelImageDownload()
        posterImageView.image = nil
    }
}

extension UpcomingMovieCell {
    func update(with movie: UpcomingMovieViewModel) {
        idLabel.text = "ID: \(movie.id)"
        nameLabel.text = "Name: \(movie.title)"
        overviewLabel.text = "Overview: \(movie.overview)"
        averagePointLabel.text = "Vote Average: \(movie.voteAverage)"
        if let posterUrl = movie.posterUrl {
            posterImageView.setImage(with: URL(string: posterUrl))
        } else {
        }
    }
}
