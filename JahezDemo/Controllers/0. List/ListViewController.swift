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
    fileprivate var collectionView: JahezCollectionView?
    fileprivate var dataSource: [RestaurantWithImage] = []
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupCollectionView()
        
        Task {
            await self.loadRestaurants()
        }
    }
    
    private func setupCollectionView() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        self.collectionView = JahezCollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: JahezCollectionView.cellIdentifier)
        self.collectionView?.delegate = self
        
        if let collection = self.collectionView {
            self.view.addSubview(collection)
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
                    self?.collectionView?.applySnapshot(restaurants: self?.dataSource ?? [])
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
}

//MARK: - Collection View Delegate
extension ListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        //TODO: - do the details
    }
}
