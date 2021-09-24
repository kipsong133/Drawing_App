//
//  DrawingViewController.swift
//  Drawing_App
//
//  Created by 김우성 on 2021/09/05.
//

import UIKit
import SnapKit
import Then

protocol DrawingViewControllerDelegate {
    func showSettingVC()
}

class DrawingViewController: UIViewController {
    
    var viewModel: DrawingViewControllerViewModel!
    var delegate: DrawingViewControllerDelegate?
    var undoMng = UndoManager()
    
    
    // MARK: - UI Object
    private var mainImageView = UIImageView().then {
        $0.backgroundColor = .white
        $0.image = UIImage(named: "Juice")
    }
    
    private var tempImageView = UIImageView().then {
        $0.backgroundColor = .clear
    }
    
    private let resetButton = UIButton().then {
        $0.setTitle("초기화", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self,
                     action: #selector(resetButtonDidTap),
                     for: .touchUpInside)
    }
    
    private let settingButton = UIButton().then {
        $0.setTitle("ReDo", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(redoDidTap), for: .touchUpInside)
        //        $0.addTarget(self,
        //                     action: #selector(settingButtonDidTap),
        //                     for: .touchUpInside)
    }
    
    private let shareButton = UIButton().then {
        $0.setTitle("공유", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(undoDidTap), for: .touchUpInside)
        
        //        $0.addTarget(self,
        //                     action: #selector(shareButtonDidTap),
        //                     for: .touchUpInside)
    }
    
    private let blackPencil = UIButton().then {
        $0.backgroundColor = .black
        $0.tag = 1
    }
    private let grayPencil = UIButton().then {
        $0.backgroundColor = .gray
        $0.tag = 2
    }
    private let redPencil = UIButton().then {
        $0.backgroundColor = .red
        $0.tag = 3
    }
    private let bluePencil = UIButton().then {
        $0.backgroundColor = .blue
        $0.tag = 4
    }
    private let skyBluePencil = UIButton().then {
        $0.backgroundColor = .systemBlue
        $0.tag = 5
    }
    private let greenPencil = UIButton().then {
        $0.backgroundColor = .green
        $0.tag = 6
    }
    private let lightGreenPencil = UIButton().then {
        $0.backgroundColor = .systemGreen
        $0.tag = 7
    }
    private let brownPencil = UIButton().then {
        $0.backgroundColor = .brown
        $0.tag = 8
    }
    private let orangePencil = UIButton().then {
        $0.backgroundColor = .orange
        $0.tag = 9
    }
    private let yellowPencil = UIButton().then {
        $0.backgroundColor = .yellow
        $0.tag = 10
    }
    private let ereaser = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.tag = 11
    }
    
    private let reDoButton = UIButton().then {
        $0.setTitle("REDO", for: .normal)
        //        $0.addTarget(self, action: #selector(redoDidTap), for: .touchUpInside)
        $0.backgroundColor = .black
    }
    private let unDoButton = UIButton().then {
        $0.setTitle("UNDO", for: .normal)
        //        $0.addTarget(self, action: #selector(undoDidTap), for: .touchUpInside)
        $0.backgroundColor = .black
    }
    
    // MARK: - Lifecycle
    init(viewModel: DrawingViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: view)
        viewModel.touchBegan(location: location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        
        viewModel.touchesMoved(currentPoint: touch.location(in: view))
        drawLine(from: viewModel.lastPoint, to: viewModel.currentPoint)
        self.view.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if !(viewModel.swiped) {
            drawLine(from: viewModel.lastPoint,
                     to: viewModel.lastPoint)
        }
        
        UIGraphicsBeginImageContext(self.mainImageView.frame.size)
        mainImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1.0)
        tempImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: viewModel.opacity) // 그리는 시점
        //        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        registerStroke(UIGraphicsGetImageFromCurrentImageContext() ?? UIImage())

        if let strokesImage = UIGraphicsGetImageFromCurrentImageContext() {
            //            viewModel.addStrokesImage(strokesImage)
            viewModel.addBuffer(strokesImage)
        }
        //        tempImageView.image = nil
    }
    
    func drawLine(from fromPoint: CGPoint,
                  to toPoint: CGPoint) {
        
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        func connectingPoint(from: CGPoint, to: CGPoint) {
            context.move(to: from)
            context.addLine(to: to)
            context.setLineCap(.round)
        }
        
        tempImageView.image?.draw(in: view.bounds)
        
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        context.setLineCap(.round)
        
        if viewModel.ereaser {
            context.setBlendMode(.clear)
            
            context.setLineWidth(viewModel.brushWidth)
        } else {
            context.setBlendMode(.normal)
            context.setLineWidth(viewModel.brushWidth)
            context.setStrokeColor(viewModel.color.cgColor)
        }
        
        context.strokePath()
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = viewModel.opacity
        //        UIGraphicsEndImageContext()
        viewModel.changePoint()
    }
    
    @objc
    func resetButtonDidTap(_ sender: UIButton) {
        
    }
    
    @objc
    func shareButtonDidTap(_ sender: UIButton) {
        logMessage("공유버튼")
    }
    
    @objc
    func settingButtonDidTap(_ sender: UIButton) {
        logMessage("설정버튼")
        delegate?.showSettingVC()
    }
    
    @objc
    func pencilButtonDidTap(_ sender: UIButton) {
        logMessage("연필버튼")
        viewModel.setColor(sender.tag)
    }
    
    @objc
    func redoDidTap() {
        //        tempImageView.image = viewModel.redoDrawing()
        //        tempImageView.image = viewModel.deqeueBuffer()
        
        self.undoMng.redo()
        
    }
    
    @objc
    func undoDidTap() {
        //        tempImageView.image = viewModel.undoDrawing()
        //        tempImageView.image = viewModel.deqeueBuffer()
        self.undoMng.undo()
        
    }
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
        
        let functionBtnArr = [resetButton, settingButton, shareButton]
        let functionStack = UIStackView().then { (make) in
            make.alignment = .fill
            functionBtnArr.forEach { functionBtn in
                make.addArrangedSubview(functionBtn)
            }
            make.backgroundColor = .lightGray
            make.distribution = .fillEqually
            make.axis = .horizontal
        }
        view.addSubview(functionStack)
        functionStack.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(view.snp.height).multipliedBy(0.1)
            $0.left.equalTo(view.snp.left)
            $0.right.equalTo(view.snp.right)
        }
        
        let pencilBtnArr = [blackPencil, grayPencil, redPencil,
                            bluePencil, skyBluePencil, greenPencil, lightGreenPencil, brownPencil, orangePencil, yellowPencil, ereaser]
        
        pencilBtnArr
            .forEach { $0.addTarget(self,
                                    action: #selector(pencilButtonDidTap),
                                    for: .touchUpInside) }
        
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
        
        view.addSubview(reDoButton)
        reDoButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
            $0.left.equalTo(view.snp.left)
            $0.bottom.equalTo(pencilStack.snp.top)
        }
        
        view.addSubview(unDoButton)
        unDoButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
            $0.right.equalTo(view.snp.right)
            $0.bottom.equalTo(pencilStack.snp.top)
        }
        
        unDoButton.isEnabled = self.undoMng.canUndo
        reDoButton.isEnabled = self.undoMng.canRedo
    }
    
    func registerStroke(_ image: UIImage) {
        
        let old = self.tempImageView.image ?? UIImage()
        
        undoMng.registerUndo(withTarget: self, handler: { target in
            target.registerStroke(old)
        })
        
        tempImageView.image = image
    }
}

