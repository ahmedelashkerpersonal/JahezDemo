//
//  DetailsViewController.swift
//  JahezDemo
//
//  Created by Ahmed Elashker on 17/01/2023.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    //MARK: - Init
    fileprivate let restaurant: RestaurantWithImage
    
    fileprivate let mainStackView: UIStackView
    
    fileprivate let imageContainer: UIView
    fileprivate let imageView: UIImageView
    
    fileprivate let nameLabel: UILabel
    fileprivate let desccriptionLabel: UILabel
    fileprivate let horizontalStackOne: UIStackView
    
    fileprivate let hoursLabel: UILabel
    fileprivate let ratingLabel: UILabel
    fileprivate let horizontalStackTwo: UIStackView

    init(restaurant: RestaurantWithImage) {
        
        self.restaurant = restaurant
        
        self.imageView = UIImageView()
        self.imageContainer = UIView()
        
        self.nameLabel = UILabel()
        self.desccriptionLabel = UILabel()
        self.horizontalStackOne = .init(arrangedSubviews: [self.nameLabel, self.desccriptionLabel])
        
        self.hoursLabel = UILabel()
        self.ratingLabel = UILabel()
        self.horizontalStackTwo = .init(arrangedSubviews: [self.hoursLabel, self.ratingLabel])
        
        self.mainStackView = .init(arrangedSubviews: [self.imageContainer, self.horizontalStackOne, self.horizontalStackTwo])
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.populate()
    }
    
    private func populate() {
        
        self.view.backgroundColor = .white
        self.view.addSubview(self.mainStackView)
        
        self.setup()
    }
    
    private func setup() {
        
        self.setupMainStack()
        self.setupImageView()
        self.setupHorizonralStackOne()
        self.setupHorizonralStackTwo()
    }

    private func setupMainStack() {
        self.mainStackView.axis = .vertical
        self.mainStackView.distribution = .fillEqually
        self.mainStackView.translatesAutoresizingMaskIntoConstraints = false

        let margins = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            self.mainStackView.topAnchor.constraint(equalTo: margins.topAnchor),
            self.mainStackView.leftAnchor.constraint(equalTo: margins.leftAnchor),
            self.mainStackView.rightAnchor.constraint(equalTo: margins.rightAnchor),
            self.mainStackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    
    private func setupImageView() {
        
        self.imageContainer.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.imageView.image = self.restaurant.image
        self.imageView.sizeToFit()
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.autoresizingMask = .flexibleHeight
        
        self.imageContainer.addSubview(self.imageView)
        
        NSLayoutConstraint.activate([
            self.imageView.centerXAnchor.constraint(equalTo: self.imageContainer.centerXAnchor),
            self.imageView.centerYAnchor.constraint(equalTo: self.imageContainer.centerYAnchor)
        ])
    }
    
    private func setupHorizonralStackOne() {
        
        self.nameLabel.text = self.restaurant.restaurant.name
        
        self.desccriptionLabel.text = self.restaurant.restaurant.description
        self.desccriptionLabel.numberOfLines = 0
        
        self.horizontalStackOne.distribution = .fill
        self.horizontalStackOne.spacing = 20
    }
    
    private func setupHorizonralStackTwo() {
        
        self.hoursLabel.text = self.restaurant.restaurant.hours
        self.hoursLabel.textAlignment = .center
        
        self.ratingLabel.text = self.restaurant.restaurant.rating.stringValue
        self.ratingLabel.textAlignment = .center
        
        self.horizontalStackTwo.distribution = .fillEqually
        self.horizontalStackTwo.spacing = 20
        self.horizontalStackTwo.alignment = .center
    }
}
