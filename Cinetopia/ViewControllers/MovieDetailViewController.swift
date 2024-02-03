//
//  MovieDetailViewController.swift
//  Cinetopia
//
//  Created by Thiago Alex on 02/02/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movie
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews:[
        movieTitleLabel,
        movieImageView,
        rateLabel,
        synopsisLabel
       ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var movieTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 32
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var rateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var synopsisLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        addSubViews()
        setupConstraint()
        setupDetails()
    }
}

extension MovieDetailViewController {
    
    private func setupDetails() {
        movieTitleLabel.text = movie.title
        movieImageView.image = UIImage(named: movie.image)
        rateLabel.text = "Classificação dos usuários: \(movie.rate)"
        synopsisLabel.text = movie.synopsis
    }
    
    private func addSubViews() {
        view.addSubview(stackView)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            movieImageView.widthAnchor.constraint(equalToConstant: 200),
            movieImageView.heightAnchor.constraint(equalToConstant: 280),
            
            synopsisLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            synopsisLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}
