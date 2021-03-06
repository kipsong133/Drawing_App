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
        let viewModel
            = DrawingViewControllerViewModel(lastPoint: .zero,
                                             color: .black,
                                             brushWidth: 10.0,
                                             opacity: 1.0,
                                             swiped: false)
        let vc = DrawingViewController(viewModel: viewModel)
        vc.delegate = self
        vc.view.backgroundColor = .white
        self.nav.navigationBar.isHidden = false
        self.nav.viewControllers = [vc]
    }
    
    func settingButtonDidTap() {
        let settingVC = SettingsViewController()
        settingVC.view.backgroundColor = .white
        self.nav.navigationBar.isHidden = false
        self.nav.pushViewController(settingVC, animated: true)
    }
}

extension DrawingViewControllerCoordinator: DrawingViewControllerDelegate {
    func showSettingVC() {
        self.settingButtonDidTap()
    }
}
