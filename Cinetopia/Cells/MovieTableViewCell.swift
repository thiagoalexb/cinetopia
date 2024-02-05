//
//  MovieTableViewCell.swift
//  Cinetopia
//
//  Created by Thiago Alex on 02/02/24.
//

import UIKit
import Kingfisher

protocol MovieTableViewCellDelegate: AnyObject {
    func didFavoriteMovie(id: Int)
}

class MovieTableViewCell: UITableViewCell {
    
    weak var delegate: MovieTableViewCellDelegate?
    
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var movieTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var movieReleaseLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white.withAlphaComponent(0.75)
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let iconImage = UIImage(systemName: "heart")?.withTintColor(UIColor(named: "ButtonBackgroundColor") ?? .blue, renderingMode: .alwaysOriginal)
        button.setImage(iconImage, for: .normal)
        button.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        setupConstraints()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(movie: Movie) {
        movieTitleLabel.text = movie.title
        let url = URL(string: movie.image)
        movieImageView.kf.setImage(with: url)
        movieReleaseLabel.text = "Lançamento \(movie.releaseDate)"
        
        let favoriteIconString = movie.isFavorite ?? false ? "heart.fill" : "heart"
        
        let iconImage = UIImage(systemName: favoriteIconString)?.withTintColor(UIColor(named: "ButtonBackgroundColor") ?? .blue, renderingMode: .alwaysOriginal)
        favoriteButton.setImage(iconImage, for: .normal)
        favoriteButton.tag = movie.id
    }
    
    private func addSubViews() {
        addSubview(movieImageView)
        addSubview(movieTitleLabel)
        addSubview(movieReleaseLabel)
        contentView.addSubview(favoriteButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            movieImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            movieImageView.widthAnchor.constraint(equalToConstant: 100),
            
            movieTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -16),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            movieReleaseLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 8),
            movieReleaseLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            
            favoriteButton.topAnchor.constraint(equalTo: movieReleaseLabel.bottomAnchor, constant: 8),
            favoriteButton.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            favoriteButton.heightAnchor.constraint(equalToConstant: 25),
            favoriteButton.widthAnchor.constraint(equalToConstant: 25)
            
        ])
    }
    
    @objc
    private func didTapFavoriteButton(sender: UIButton) {
        delegate?.didFavoriteMovie(id: sender.tag)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
