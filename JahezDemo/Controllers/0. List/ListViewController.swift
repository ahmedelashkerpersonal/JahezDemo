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
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Task {
            await self.loadRestaurants()
        }
    }

    private func loadRestaurants() async {
        
        do {
            let restaurants = try await networkManager.loadRestaurants()
            //TODO: - Build UI to show the data
            
        } catch {
            self.showErrorAlert(error: error,
                                retryBlock: { [weak self] _ in
                Task {
                    await self?.loadRestaurants()
                }
            })
        }
        
    }
    
}
