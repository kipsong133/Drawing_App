//
//  DrawingViewControllerCoordinator.swift
//  Drawing_App
//
//  Created by 김우성 on 2021/09/05.
//

import UIKit

class DrawingViewControllerCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = []
    
    private var nav: UINavigationController!
    
    init(nav: UINavigationController) {
        self.nav = nav
    }
    
    func start() {
        // present VC
        let vc = DrawingViewController()
        vc.view.backgroundColor = .white
        self.nav.navigationBar.isHidden = true
        self.nav.viewControllers = [vc]
    }
}
