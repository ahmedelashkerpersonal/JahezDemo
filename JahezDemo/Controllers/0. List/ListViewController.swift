//
//  ListViewController.swift
//  JahezDemo
//
//  Created by Ahmed Elashker on 17/01/2023.
//

import UIKit

final class ListViewController: UIViewController {
    
    //MARK: - Properties
    fileprivate let networkManager = NetworkManager()
    fileprivate var segmentedControl: UISegmentedControl?
    fileprivate var collectionView: JahezCollectionView?
    fileprivate var dataSource: [RestaurantWithImage] = []
    fileprivate var dataSourceByDistance: [RestaurantWithImage] {
        return self.dataSource.sorted(by: {$0.restaurant.distance < $1.restaurant.distance})
    }
    fileprivate var dataSourceByRating: [RestaurantWithImage] {
        return self.dataSource.sorted(by: {$0.restaurant.rating > $1.restaurant.rating})
    }
    fileprivate var dataSourceByOffers: [RestaurantWithImage] {
        return self.dataSource.filter({$0.restaurant.hasOffer == true})
    }
    fileprivate var viewDataSource: [RestaurantWithImage] = [] {
        didSet {
            self.collectionView?.applySnapshot(restaurants: self.viewDataSource)
        }
    }
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setup()
        
        Task {
            await self.loadRestaurants()
        }
    }
    
    private func setup() {
        
        self.setupSegmentedControl()
        self.setupCollectionView()
    }
    
    private func setupSegmentedControl() {
        
        self.segmentedControl = .init(items: [NSLocalizedString("Distance", comment: ""),
                                              NSLocalizedString("Rating", comment: ""),
                                              NSLocalizedString("Offers", comment: "")])
        self.segmentedControl?.selectedSegmentIndex = 0
        self.segmentedControl?.selectedSegmentTintColor = .systemTeal
        
        let selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.segmentedControl?.setTitleTextAttributes(selectedTitleTextAttributes, for: .selected)
        
        let normalTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.segmentedControl?.setTitleTextAttributes(normalTitleTextAttributes, for: .normal)
        
        if let segmentedControl = self.segmentedControl {
            
            self.navigationItem.titleView = segmentedControl
            segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        }
    }
    
    private func setupCollectionView() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        self.collectionView = JahezCollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: JahezCollectionView.cellIdentifier)
        self.collectionView?.delegate = self
        
        if let collectionView = self.collectionView {
            
            self.view.addSubview(collectionView)
        }
    }
    
    private func loadRestaurants() async {
        
        do {
            let restaurants = try await self.networkManager.loadRestaurants()
            restaurants.forEach { [weak self] restaurant in
                Task {
                    let image = await self?.loadImage(urlString: restaurant.image)
                    let restaurantWithImage = RestaurantWithImage(restaurant: restaurant, image: image)
                    self?.dataSource.append(restaurantWithImage)
                    self?.viewDataSource = self?.dataSourceByDistance ?? []
                }
            }
        } catch {
            self.showErrorAlert(error: error,
                                retryBlock: { [weak self] _ in
                Task {
                    await self?.loadRestaurants()
                }
            })
        }
        
    }
    
    private func loadImage(urlString: String) async -> UIImage? {
        
        do {
            let image = try await self.networkManager.loadImage(urlString: urlString)
            return image
        } catch {
            print("Couldn't load image from url: \(urlString)")
            return nil
        }
        
    }
    
    //MARK: - Actions
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.viewDataSource = self.dataSourceByDistance
        case 1:
            self.viewDataSource = self.dataSourceByRating
        case 2:
            self.viewDataSource = self.dataSourceByOffers
        default:
            self.viewDataSource = self.dataSourceByDistance
        }
    }
}

//MARK: - Collection View Delegate
extension ListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let restaurant = self.viewDataSource[indexPath.row]
        let detailsVC = DetailsViewController(restaurant: restaurant)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
