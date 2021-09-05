//
//  SettingsViewController.swift
//  Drawing_App
//
//  Created by 김우성 on 2021/09/05.
//

import UIKit
import SnapKit
import Then

class SettingsViewController: UIViewController {
        
    // MARK: - UI Object
    private let brushSlider = UISlider().then {
        $0.value = 10
        $0.minimumValue = 1
        $0.maximumValue = 80
        $0.addTarget(self,
                     action: #selector(brushDidChanged),
                     for: .valueChanged)
    }
    private let opacitySlider = UISlider().then {
        $0.value = 1
        $0.minimumValue = 0
        $0.maximumValue = 1
        $0.addTarget(self,
                     action: #selector(opacityDidChanged),
                     for: .valueChanged)
    }
    private let redSlider = UISlider().then {
        $0.value = 0
        $0.minimumValue = 0
        $0.maximumValue = 255
        $0.addTarget(self,
                     action: #selector(redDidChanged),
                     for: .valueChanged)
    }
    private let greenSlider = UISlider().then {
        $0.value = 0
        $0.minimumValue = 0
        $0.maximumValue = 255
        $0.addTarget(self,
                     action: #selector(greenDidChanged),
                     for: .valueChanged)
    }
    private let blueSlider = UISlider().then {
        $0.value = 0
        $0.minimumValue = 0
        $0.maximumValue = 255
        $0.addTarget(self,
                     action: #selector(blueDidChanged),
                     for: .valueChanged)
    }
    
    private let brushTitleLabel = UILabel().then {
        $0.text = "Brush"
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.textColor = .black
    }
    private let opacityTitleLabel = UILabel().then {
        $0.text = "Opacity"
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.textColor = .black
    }
    private let rgbTitleLabel = UILabel().then {
        $0.text = "RGB"
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.textColor = .black
    }
    private let brushStateLabel = UILabel().then {
        $0.text = "10.0"
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .black
    }
    private let opacityStateLabel = UILabel().then {
        $0.text = "1.0"
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .black
    }
    private let redStateLabel = UILabel().then {
        $0.text = "0"
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .red
    }
    private let greenStateLabel = UILabel().then {
        $0.text = "0"
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .green
    }
    private let blueStateLabel = UILabel().then {
        $0.text = "0"
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .blue
    }
    
    private let previewImageView = UIImageView().then {
        $0.backgroundColor = .lightGray
    }
    
}

// MARK: - View Lifecycle
extension SettingsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}

// MARK: - Actions
extension SettingsViewController {
    
    @objc
    func brushDidChanged(_ sender: UISlider) {
        logMessage("브러쉬: \(sender.value)")
    }
    
    @objc
    func opacityDidChanged(_ sender: UISlider) {
        logMessage("투명도: \(sender.value)")
    }
    
    @objc
    func redDidChanged(_ sender: UISlider) {
        logMessage("빨강: \(sender.value)")
    }
    
    @objc
    func greenDidChanged(_ sender: UISlider) {
        logMessage("초록: \(sender.value)")
    }
    
    @objc
    func blueDidChanged(_ sender: UISlider) {
        logMessage("파랑: \(sender.value)")
    }

}

// MARK: - Helpers
extension SettingsViewController {
    
    func setupLayout() {
        
        view.backgroundColor = .white

        let brushStack = UIStackView().then {
            $0.alignment = .fill
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.spacing = 10
            $0.addArrangedSubview(brushTitleLabel)
            $0.addArrangedSubview(brushSlider)
            $0.addArrangedSubview(brushStateLabel)
        }
        view.addSubview(brushStack)
        brushStack.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.centerX.equalTo(view.snp.centerX)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right)
                .offset(-20)
        }
        brushSlider.snp.makeConstraints {
            $0.width.equalTo(view.snp.width).multipliedBy(0.45)
            $0.height.equalTo(brushStack.snp.height)
        }
        
        let opacityStack = UIStackView().then {
            $0.alignment = .fill
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.spacing = 3
            $0.addArrangedSubview(opacityTitleLabel)
            $0.addArrangedSubview(opacitySlider)
            $0.addArrangedSubview(opacityStateLabel)
        }
        view.addSubview(opacityStack)
        opacityStack.snp.makeConstraints {
            $0.top.equalTo(brushStack.snp.bottom).offset(10)
            $0.centerX.equalTo(view.snp.centerX)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right)
                .offset(-20)
        }
        opacitySlider.snp.makeConstraints {
            $0.width.equalTo(view.snp.width).multipliedBy(0.4)
            $0.height.equalTo(opacityStack.snp.height)
        }

        view.addSubview(previewImageView)
        previewImageView.snp.makeConstraints {
            $0.top.equalTo(opacityStack.snp.bottom).offset(15)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(view.snp.width).multipliedBy(0.28)
            $0.height.equalTo(view.snp.width).multipliedBy(0.28)
        }
        
        view.addSubview(redSlider)
        redSlider.snp.makeConstraints {
            $0.top.equalTo(previewImageView.snp.bottom).offset(20)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(view.snp.width).multipliedBy(0.45)
            $0.height.equalTo(0).offset(20)
        }
        
        view.addSubview(greenSlider)
        greenSlider.snp.makeConstraints {
            $0.top.equalTo(redSlider.snp.bottom).offset(20)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(view.snp.width).multipliedBy(0.45)
            $0.height.equalTo(0).offset(20)
        }
        
        view.addSubview(blueSlider)
        blueSlider.snp.makeConstraints {
            $0.top.equalTo(greenSlider.snp.bottom).offset(20)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(view.snp.width).multipliedBy(0.45)
            $0.height.equalTo(0).offset(20)
        }
        
        view.addSubview(rgbTitleLabel)
        rgbTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(redSlider.snp.centerY)
            $0.right.equalTo(redSlider.snp.left).offset(-20)
        }
        
        view.addSubview(redStateLabel)
        redStateLabel.snp.makeConstraints {
            $0.centerY.equalTo(redSlider.snp.centerY)
            $0.left.equalTo(redSlider.snp.right).offset(20)
        }
        
        view.addSubview(greenStateLabel)
        greenStateLabel.snp.makeConstraints {
            $0.centerY.equalTo(greenSlider.snp.centerY)
            $0.left.equalTo(redSlider.snp.right).offset(20)
        }
        
        view.addSubview(blueStateLabel)
        blueStateLabel.snp.makeConstraints {
            $0.centerY.equalTo(blueSlider.snp.centerY)
            $0.left.equalTo(blueSlider.snp.right).offset(20)
        }
        
        
    }
}

