//
//  DrawingViewController.swift
//  Drawing_App
//
//  Created by 김우성 on 2021/09/05.
//

import UIKit
import SnapKit
import Then

class DrawingViewController: UIViewController {
    
    // MARK: - UI Object
    private let mainImageView = UIImageView().then {
        $0.backgroundColor = .white
    }
    
    private let tempImageView = UIImageView().then {
        $0.backgroundColor = .white
    }
    
    private let ressetButton = UIButton().then {
        $0.setTitle("초기화", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    private let settingButton = UIButton().then {
        $0.setTitle("설정", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    private let shareButton = UIButton().then {
        $0.setTitle("공유", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    private let blackPencil = UIButton().then {
        $0.backgroundColor = .black
    }
    private let grayPencil = UIButton().then {
        $0.backgroundColor = .gray
    }
    private let redPencil = UIButton().then {
        $0.backgroundColor = .red
    }
    private let bluePencil = UIButton().then {
        $0.backgroundColor = .blue
    }
    private let skyBluePencil = UIButton().then {
        $0.backgroundColor = .systemBlue
    }
    private let greenPencil = UIButton().then {
        $0.backgroundColor = .green
    }
    private let lightGreenPencil = UIButton().then {
        $0.backgroundColor = .systemGreen
    }
    private let brownPencil = UIButton().then {
        $0.backgroundColor = .brown
    }
    private let orangePencil = UIButton().then {
        $0.backgroundColor = .orange
    }
    private let yellowPencil = UIButton().then {
        $0.backgroundColor = .yellow
    }
    private let ereaser = UIButton().then {
        $0.backgroundColor = .purple
    }
}

// MARK: - View Lifecycle
extension DrawingViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}

// MARK: - Actions
extension DrawingViewController {
    
}

// MARK: - Helpers
extension DrawingViewController {
    
    func setupLayout() {
        
        view.addSubview(mainImageView)
        mainImageView.snp.makeConstraints {
            $0.width.equalTo(view.snp.width)
            $0.height.equalTo(view.snp.height)
        }
        
        view.addSubview(tempImageView)
        tempImageView.snp.makeConstraints {
            $0.width.equalTo(view.snp.width)
            $0.height.equalTo(view.snp.height)
        }
        let pencilBtnArr = [blackPencil, grayPencil, redPencil,
        bluePencil, skyBluePencil, greenPencil, lightGreenPencil, brownPencil, orangePencil, yellowPencil, ereaser]
        
        let pencilStack = UIStackView().then { (make) in
            make.alignment = .fill
            pencilBtnArr.forEach { pencilBtn in
                make.addArrangedSubview(pencilBtn)
            }
            make.axis = .horizontal
            make.distribution = .fillEqually
        }
        
        view.addSubview(pencilStack)
        pencilStack.snp.makeConstraints {
            $0.width.equalTo(view.snp.width).multipliedBy(0.88)
            $0.height.equalTo(view.snp.height).multipliedBy(0.15)
            $0.bottom.equalTo(view.snp.bottom)
            $0.left.equalTo(view.snp.left)
        }
    }
}

