//
//  SplashScreenViewController.swift
//  Netflix
//
//  Created by shubam on 05/07/24.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "netflixLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpLogoImageView()
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(navigateToMainScreen), userInfo: nil, repeats: false)
    }
    
    private func setUpLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    @objc func navigateToMainScreen() {
        let mainVC = UINavigationController(rootViewController: MainViewController())
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: false)
    }
    
}
