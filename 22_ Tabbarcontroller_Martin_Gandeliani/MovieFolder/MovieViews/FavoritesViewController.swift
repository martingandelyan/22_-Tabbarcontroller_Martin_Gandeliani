//
//  FavoritesViewController.swift
//  22_ Tabbarcontroller_Martin_Gandeliani
//
//  Created by Martin on 07.12.25.
//

import Foundation
import UIKit

class FavoritesViewController: UIViewController {
    
    var viewModelFavorite = FavoritesViewModel()
    let favoriteTableView = UITableView()
    
    init(viewModel: FavoritesViewModel) {
            self.viewModelFavorite = viewModel
            super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupFavoritesUi()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func bindViewModel() {
        viewModelFavorite.movieAdded = { [weak self] in
            self?.favoriteTableView.reloadData()
        }
    }
    
    func setupFavoritesUi() {
            view.addSubview(favoriteTableView)
            favoriteTableView.dataSource = self
            favoriteTableView.delegate = self
            favoriteTableView.translatesAutoresizingMaskIntoConstraints = false
            favoriteTableView.backgroundColor = .white
            favoriteTableView.register(RemoveFromFavoriteCell.self, forCellReuseIdentifier: "RemoveFromFavoriteCell")
        
        NSLayoutConstraint.activate([
                favoriteTableView.topAnchor.constraint(equalTo: view.topAnchor),
                favoriteTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                favoriteTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                favoriteTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelFavorite.favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let removeFromFavorCell = tableView.dequeueReusableCell(withIdentifier: "RemoveFromFavoriteCell", for: indexPath) as! RemoveFromFavoriteCell
        let currentMovie = viewModelFavorite.favoriteMovies[indexPath.row]
        
        removeFromFavorCell.configure(with: currentMovie)
        removeFromFavorCell.delegate = self
        
        return removeFromFavorCell
    }
}

extension FavoritesViewController: RemoveFromFavoriteCellDelegate {
    func removeFromFavorites(movie: Movie) {
        viewModelFavorite.removeMovieFromFavorites(movie: movie)
        viewModelFavorite.refreshTab()
    }
}

extension FavoritesViewController: MovieDetailsDelegate {
    func addFavoritesTapped(movie: Movie) {
        viewModelFavorite.addMovieToFavorites(movie: movie)
    }
}
