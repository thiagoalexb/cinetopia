//
//  MoviesViewController.swift
//  Cinetopia
//
//  Created by Thiago Alex on 02/02/24.
//

import UIKit

class MoviesViewController: UIViewController {
    
    private var movies: [Movie] = []
    private var filteredMovies: [Movie] = []
    private var isSearchActive: Bool = false
    private let movieService: MovieService = MovieService()
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Pesquisar"
        searchBar.searchTextField.backgroundColor = .white
        searchBar.delegate = self
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setupNavigationBar()
        addSubViews()
        setupConstraints()
        Task {
            await getMovies()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
}

extension MoviesViewController {
    
    private func setupNavigationBar() {
        title = "Flmes populares"
        navigationController?.navigationBar.prefersLargeTitles = true
        let font = UIFont.systemFont(ofSize: 24)
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: font
        ]
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.titleView = searchBar

    }
    
    private func addSubViews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func getMovies() async {
        do {
            movies = try await movieService.getMovies()
            filteredMovies = movies
            tableView.reloadData()
        }catch(let error ) {
            print(error)
        }
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell {
            cell.configureCell(movie: filteredMovies[indexPath.row])
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = MovieDetailViewController(movie: filteredMovies[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160 
    }
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearchActive = !searchText.isEmpty
        
        if !searchText.isEmpty {
            filteredMovies = movies.filter({ movie in
                movie.title.lowercased().contains(searchText.lowercased())
            })
        } else {
            filteredMovies = movies
        }
        
        tableView.reloadData()
    }
}

extension MoviesViewController: MovieTableViewCellDelegate {
    func didFavoriteMovie(id: Int) {
        if let index = movies.firstIndex(where: { movies in
            movies.id == id
        }) {
            let movie = movies[index]
            if(movie.isFavorite ?? false) {
                MovieManager.shared.removeFavorite(id: movie.id)
            } else {
                MovieManager.shared.addFavorite(movie: movie)
            }
            
            movie.changeFavoriteStatus()
            
            tableView.reloadData()
        }
    }
}
