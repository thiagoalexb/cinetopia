//
//  FavoriteMoviesViewController.swift
//  Cinetopia
//
//  Created by Thiago Alex on 03/02/24.
//

import UIKit

class FavoriteMoviesViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layoutCollectionView = UICollectionViewFlowLayout()
        layoutCollectionView.sectionInset = UIEdgeInsets(top: 20, left: 27, bottom: 10, right: 27)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutCollectionView)
        collectionView.register(FavoriteMovieCollectionViewCell.self, forCellWithReuseIdentifier: "favoriteMovie")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setupNavigationBar()
        addSubViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
}

extension FavoriteMoviesViewController {
    
    private func setupNavigationBar() {
        title = "Meus filmes favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        let font = UIFont.systemFont(ofSize: 24)
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: font
        ]
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func addSubViews() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FavoriteMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        MovieManager.shared.favoritesMovies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteMovie", for: indexPath) as? FavoriteMovieCollectionViewCell else {
            fatalError("error to create FavoriteMovieCollectionViewCell")
        }
        
        let currentMovie = MovieManager.shared.favoritesMovies[indexPath.row]
        cell.configureCell(movie: currentMovie)
        cell.delegate = self
        
        return cell
    }
}

extension FavoriteMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: 200)
    }
}

extension FavoriteMoviesViewController: FavoriteMovieCollectionViewCellDelegate {
    func didRemoveFavorite(id: Int) {
        if let index = MovieManager.shared.favoritesMovies.firstIndex(where: { movies in
            movies.id == id
        }) {
            let movie = MovieManager.shared.favoritesMovies[index]
            MovieManager.shared.removeFavorite(id: movie.id)
            
            movie.changeFavoriteStatus()
            
            collectionView.reloadData()
        }
    }
    
    
}
