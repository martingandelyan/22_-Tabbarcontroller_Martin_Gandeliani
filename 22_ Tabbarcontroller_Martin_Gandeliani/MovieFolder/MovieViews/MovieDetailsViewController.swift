//
//  MovieDetailsViewController.swift
//  20_ MVVM_Martin_Gandeliani
//
//  Created by Martin on 01.12.25.
//

import Foundation

import UIKit

class MovieDetailsViewController: UIViewController {
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let yearLabel = UILabel()
    private let ratingsLabel = UILabel()
    private let addToFavoritesBtn = UIButton()
    
    var movie: Movie?
    weak var delegate: MovieDetailsDelegate?
    
    init(movie: Movie) {
            self.movie = movie
            super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        configureUi()
    }
    
    func setupUI() {
        [posterImageView, titleLabel, yearLabel, ratingsLabel, addToFavoritesBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        addToFavoritesBtn.setTitle(" Add to favorites ", for: .normal)
        addToFavoritesBtn.layer.cornerRadius = 8
        addToFavoritesBtn.setTitleColor(.white, for: .normal)
        addToFavoritesBtn.backgroundColor = .systemBlue
        addToFavoritesBtn.addAction(UIAction(handler: { [weak self] _ in
            //add action
            guard let movie = self?.movie else { return }
            self?.delegate?.addFavoritesTapped(movie: movie)
        }), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 200),
            posterImageView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            yearLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            ratingsLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 10),
            ratingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ratingsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addToFavoritesBtn.topAnchor.constraint(equalTo: ratingsLabel.bottomAnchor, constant: 20),
            addToFavoritesBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            addToFavoritesBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    func configureUi() {
        guard let movie = movie else { return }
        titleLabel.text = "Title: \(movie.title)"
        yearLabel.text = "Year: \(movie.year)"
        
        if let url = URL(string: movie.poster) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                self.posterImageView.image = UIImage(data: data)
            }.resume()
        }
    }
}

protocol MovieDetailsDelegate: AnyObject {
    func addFavoritesTapped(movie: Movie)
}
