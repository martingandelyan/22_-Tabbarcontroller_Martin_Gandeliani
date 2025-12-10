//
//  MoviewCell 2.swift
//  22_ Tabbarcontroller_Martin_Gandeliani
//
//  Created by Martin on 10.12.25.
//

import UIKit

class RemoveFromFavoriteCell: UITableViewCell {
    
    private let titleLbl = UILabel()
    private let yearLbl = UILabel()
    private let sourceLbl = UILabel()
    private let valueLbl = UILabel()
    private let removeFromFavoritesBtn = UIButton()
    
    weak var delegate: RemoveFromFavoriteCellDelegate?
    private var currentMovie: Movie?
    
    private let posterImageView: UIImageView = {
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
        let uiComponents = [posterImageView, titleLbl, yearLbl, sourceLbl, valueLbl, removeFromFavoritesBtn]
        uiComponents.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        posterImageView.layer.cornerRadius = 5
        
        removeFromFavoritesBtn.setTitle(" ❌ ", for: .normal)
        removeFromFavoritesBtn.setTitleColor(.black, for: .normal)
        removeFromFavoritesBtn.backgroundColor = .systemBlue
        removeFromFavoritesBtn.layer.cornerRadius = 10
        removeFromFavoritesBtn.addAction(UIAction(handler: { [weak self] _ in
            self?.removeFromFavorites()
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
            
            removeFromFavoritesBtn.topAnchor.constraint(equalTo: yearLbl.bottomAnchor, constant: 20),
            removeFromFavoritesBtn.centerXAnchor.constraint(equalTo: yearLbl.centerXAnchor),
            removeFromFavoritesBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
    }
    
    func removeFromFavorites() {
        if let movie = currentMovie {
            delegate?.removeFromFavorites(movie: movie)
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

protocol RemoveFromFavoriteCellDelegate: AnyObject {
    func removeFromFavorites(movie: Movie)
}


