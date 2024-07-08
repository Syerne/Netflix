//
//  MovieDetailScreenViewController.swift
//  Netflix
//
//  Created by shubam on 06/07/24.
//

import UIKit

class MovieDetailScreenViewController: UIViewController {
    
    var movieDetail: MovieDetailModel
    
    // UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let yearLabel = UILabel()
    private let plotLabel = UILabel()
    private let genreLabel = UILabel()
    private let ratingsLabel = UILabel()
    
    init(movieDetail: MovieDetailModel) {
        self.movieDetail = movieDetail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        // Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.addSubview(posterImageView)
        view.addSubview(titleLabel)
        view.addSubview(yearLabel)
        view.addSubview(plotLabel)
        view.addSubview(genreLabel)
        view.addSubview(ratingsLabel)
        
        // Set translatesAutoresizingMaskIntoConstraints to false for Auto Layout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        plotLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            posterImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            yearLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            yearLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            plotLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 20),
            plotLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            plotLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            genreLabel.topAnchor.constraint(equalTo: plotLabel.bottomAnchor, constant: 20),
            genreLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            genreLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            ratingsLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 20),
            ratingsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingsLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ])
    }
    
    private func configureUI() {
        // Configure UI elements with data
        if let posterURL = URL(string: movieDetail.poster) {
            posterImageView.load(url: posterURL)
        }
        
        titleLabel.text = movieDetail.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        
        yearLabel.text = movieDetail.year
        yearLabel.font = UIFont.systemFont(ofSize: 18)
        yearLabel.textColor = .gray
        
        plotLabel.text = movieDetail.plot
        plotLabel.font = UIFont.systemFont(ofSize: 16)
        plotLabel.numberOfLines = 0
        
        genreLabel.text = "Genre: \(movieDetail.genre)"
        genreLabel.font = UIFont.systemFont(ofSize: 16)
        genreLabel.numberOfLines = 0
        
        ratingsLabel.text = movieDetail.ratings.map { "\($0.source): \($0.value)" }.joined(separator: "\n")
        ratingsLabel.font = UIFont.systemFont(ofSize: 16)
        ratingsLabel.numberOfLines = 0
    }
}

// Extension to load image from URL
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
