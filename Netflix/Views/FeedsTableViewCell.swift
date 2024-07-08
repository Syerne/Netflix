//
//  FeedsTableViewCell.swift
//  Netflix
//
//  Created by shubam on 05/07/24.
//

import UIKit

class FeedsTableViewCell: UITableViewCell {
    static let identifier = "FeedsTableViewCell"
    var movie: Movie?
    
    // MARK: - Properties
    let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemMint
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "Released Date: "
        return dateLabel
    }()
    
    let favoriteButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "star"), for: .normal)
        btn.setImage(UIImage(systemName: "star.fill"), for: .selected)
        return btn
    }()
    
    var updateFavMoviesList : ((String) -> Void)?
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.backgroundColor = .systemBackground
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(customImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(favoriteButton)
        
        // Setup the constraints
        NSLayoutConstraint.activate([
            customImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            customImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            customImageView.widthAnchor.constraint(equalToConstant: 100),
            customImageView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: customImageView.topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            releaseDateLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 10),
            releaseDateLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            releaseDateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            favoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Customize the appearance
        customImageView.contentMode = .scaleAspectFill
        customImageView.clipsToBounds = true
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
        
        releaseDateLabel.font = UIFont.systemFont(ofSize: 14)
        releaseDateLabel.textColor = .gray
        
        
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    }
    
    func configureFavButton() {
        favoriteButton.isSelected = true
    }
    
    func configureCell(with movie: Movie) {
        self.movie = movie
        titleLabel.text = movie.title
        releaseDateLabel.text = "Released Date: \(movie.year)"
        if let posterURL = URL(string: movie.poster) {
            self.customImageView.load(url: posterURL)
        }
    }
    
    @objc private func didTapFavoriteButton() {
        guard let movie = movie else { return }
        //        let isFavorite = !favoriteButton.isSelected
        favoriteButton.isSelected.toggle()
        
        updateFavMoviesList?(movie.id)
        
        if !favoriteButton.isSelected {
            saveMoviePoster(movie)
        }
    }
    
    private func saveMoviePoster(_ movie: Movie) {
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: movie.poster), let data = try? Data(contentsOf: url) else { return }
            UserDefaults.standard.set(data, forKey: "\(movie.id)_poster")
        }
    }
    
}

