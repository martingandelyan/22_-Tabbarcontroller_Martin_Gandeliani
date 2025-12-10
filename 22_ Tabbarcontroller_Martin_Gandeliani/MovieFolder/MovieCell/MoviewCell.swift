//
//  MoviesManager.swift
//  19_Networking-2_Martin_Gandeliani
//
//  Created by Martin on 28.11.25.
//

import UIKit

class MoviewCell: UITableViewCell {
    
    let titleLbl = UILabel()
    let yearLbl = UILabel()
    let sourceLbl = UILabel()
    let valueLbl = UILabel()
    let addToFavoritesBtn = UIButton()
    
    weak var delegate: MoviewCellDelegate?
    var currentMovie: Movie?
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUi() {
        let uiComponents = [posterImageView, titleLbl, yearLbl, sourceLbl, valueLbl, addToFavoritesBtn]
        uiComponents.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        posterImageView.layer.cornerRadius = 5
        
        addToFavoritesBtn.setTitle(" Add to favorites ", for: .normal)
        addToFavoritesBtn.setTitleColor(.black, for: .normal)
        addToFavoritesBtn.backgroundColor = .systemBlue
        addToFavoritesBtn.layer.cornerRadius = 10
        addToFavoritesBtn.addAction(UIAction(handler: { [weak self] _ in
            self?.addFvrButtonTapped()
        }), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            posterImageView.heightAnchor.constraint(equalToConstant: 250),
            
            titleLbl.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            titleLbl.centerXAnchor.constraint(equalTo: posterImageView.centerXAnchor),
            titleLbl.bottomAnchor.constraint(equalTo: yearLbl.topAnchor, constant: -10),
            
            yearLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 20),
            yearLbl.centerXAnchor.constraint(equalTo: titleLbl.centerXAnchor),
            yearLbl.bottomAnchor.constraint(equalTo: sourceLbl.topAnchor, constant: -10),
            
            addToFavoritesBtn.topAnchor.constraint(equalTo: yearLbl.bottomAnchor, constant: 20),
            addToFavoritesBtn.centerXAnchor.constraint(equalTo: yearLbl.centerXAnchor),
            addToFavoritesBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
    }
    
    func addFvrButtonTapped() {
        if let movie = currentMovie {
            delegate?.addToFavorites(movie: movie)
        }
    }
    
    func loadPoster(movie: Movie) {
        if let url = URL(string: movie.poster) {
            URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: data)
                    }
                }.resume()
            } else {
                print("სურათი ვერ ჩამოიტვირთა")
                posterImageView.image = nil
            }
    }
    
    func configure(with movie: Movie) {
        currentMovie = movie
        titleLbl.text = "Movie title: \(movie.title)"
        yearLbl.text = "Movie year: \(movie.year)"
        loadPoster(movie: movie)
        }
    }

protocol MoviewCellDelegate: AnyObject {
    func addToFavorites(movie: Movie)
}

