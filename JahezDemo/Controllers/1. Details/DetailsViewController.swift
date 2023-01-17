//
//  DetailsViewController.swift
//  JahezDemo
//
//  Created by Ahmed Elashker on 17/01/2023.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    //MARK: - Properties
    fileprivate var stackView: UIStackView?
    fileprivate var imageView: UIImageView?
    fileprivate var nameLabel: UILabel?
    fileprivate var desccriptionLabel: UILabel?
    fileprivate var hoursLabel: UILabel?
    fileprivate var ratingLabel: UILabel?

    //MARK: - Init
    fileprivate let restaurant: RestaurantWithImage
    init(restaurant: RestaurantWithImage) {
        
        self.restaurant = restaurant
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
        
        //TODO: - Construct the view
        self.imageView = UIImageView(image: self.restaurant.image)
        self.view.addSubview(imageView!)
    }

}
