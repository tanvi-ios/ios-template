//
//  AppCoordinator.swift
//  Template
//
//  Created by Apple on 03/03/22.
//

import Foundation
import UIKit


class AppCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    
    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let itunesApiService = ItunesApiService()
        let homeVM = HomeVM(with: itunesApiService)
        let rootViewController = HomeVC(with: homeVM)
        
        rootViewController.showDetail = { [weak self] result in
            self?.showDetail(with: result)
        }
        
        navigationController.navigationBar.barStyle = .black
        navigationController.pushViewController(rootViewController, animated: false)
    }
    
    func showDetail(with result: SongModel) {
        let detailVC = DetailVC(with: result)
        navigationController.pushViewController(detailVC, animated: true)
    }
    
}
