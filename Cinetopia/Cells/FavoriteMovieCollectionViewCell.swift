//
//  FavoriteMoviesViewController.swift
//  Cinetopia
//
//  Created by Thiago Alex on 03/02/24.
//

import UIKit

protocol FavoriteMovieCollectionViewCellDelegate: AnyObject {
    func didRemoveFavorite(id: Int)
}

class FavoriteMovieCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: FavoriteMovieCollectionViewCellDelegate?
    
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
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let iconImage = UIImage(systemName: "heart.fill")?.withTintColor(UIColor(named: "ButtonBackgroundColor") ?? .blue, renderingMode: .alwaysOriginal)
        button.setImage(iconImage, for: .normal)
        button.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteMovieCollectionViewCell {
    
    private func addSubViews() {
        addSubview(movieImageView)
        addSubview(movieTitleLabel)
        addSubview(favoriteButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 140),
            
            movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 4),
            movieTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 4),
            favoriteButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func configureCell(movie: Movie) {
        let url = URL(string: movie.image)
        movieImageView.kf.setImage(with: url)
        movieTitleLabel.text = movie.title
        favoriteButton.tag = movie.id
    }
    
    @objc
    private func didTapFavoriteButton(sender: UIButton) {
        delegate?.didRemoveFavorite(id: sender.tag)
    }
}
