//
//  AppCoordinator.swift
//  Drawing_App
//
//  Created by 김우성 on 2021/09/05.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinator: [Coordinator] { get set }
    func start()
}

class AppCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = []
    private var nav: UINavigationController!
    
    init(nav: UINavigationController) {
        self.nav = nav
    }
    
    func start() {
        // Launched App, present initial VC
        self.showDrawingVC()
    }
    
    private func showDrawingVC() {
        let coordinator = DrawingViewControllerCoordinator(nav: self.nav)
        coordinator.start()
        self.childCoordinator.append(coordinator)
    }
    
    
}
