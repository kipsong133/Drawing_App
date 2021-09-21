//
//  DrawingViewControllerViewModel.swift
//  Drawing_App
//
//  Created by 김우성 on 2021/09/05.
//

import Foundation
import UIKit

class DrawingViewControllerViewModel {
    
    var lastPoint: CGPoint
    var currentPoint: CGPoint = CGPoint()
    var color: UIColor
    var brushWidth: CGFloat
    var opacity: CGFloat
    var swiped: Bool
    var ereaser: Bool = false

    var strokes: [UIImage] = []
    var currentIndex: Int = 0
    
    init(lastPoint: CGPoint,
         color: UIColor,
         brushWidth: CGFloat,
         opacity: CGFloat,
         swiped: Bool) {
        
        self.lastPoint = lastPoint
        self.color = color
        self.brushWidth = brushWidth
        self.opacity = opacity
        self.swiped = swiped
    }
    
    func touchBegan(location: CGPoint) {
        swiped = false
        lastPoint = location
    }
    
    func touchesMoved(currentPoint: CGPoint) {
        swiped = true
        self.currentPoint = currentPoint
        
    }
    
    func changePoint() {
        self.lastPoint = self.currentPoint
    }
    
    func setColor(_ colorButtonTagValue: Int) {
        
        guard let pencil = Pencil(tag: colorButtonTagValue) else { return }
        color = pencil.color
        
        if pencil == .eraser {
            self.ereaser = true
        } else {
            self.ereaser = false
        }
    }
    
    func addStrokesImage(_ image: UIImage) {
        self.strokes.append(image)
    }
    
    func undoDrawing() -> UIImage? {
        let lastIndex = strokes.count - 1

        if currentIndex == lastIndex {
            // 제일 마지막에 입력된 이미지를 리턴한다.
            currentIndex -= 1
            guard let lastImage = self.strokes.last else { return nil }
            return lastImage
            
        } else {
            // 마지막 인덱스에서 하나 뺀 값의 인덱스 이미지를 리턴한다.
            currentIndex -= 1
            let currentImage = self.strokes[currentIndex]
            return currentImage
        }
    }
    
    func redoDrawing() -> UIImage? {
        let lastIndex = strokes.count - 1
        let currentIndex = self.currentIndex
        
        if currentIndex == lastIndex {
            guard let lastImage = self.strokes.last else { return nil}
            return lastImage
            
        } else {
            self.currentIndex += 1
            let previousImage = self.strokes[self.currentIndex]
            return previousImage
        }
    }
    
//    func layerManager(_ type: DrawingOperatorType) {
//        var layer: [UIImage] = []
//        var currentId = self.currentIndex
//
//        if type == .undo {
//            guard currentId == 0 else { return }
//            currentId = currentId - 1
//            let image = layer[currentId]
//
//        } else {
//            guard currentId == (layer.count - 1) else { return }
//            currentId = currentId + 1
//            let image = layer[currentId]
//        }
//    }
}

enum DrawingOperatorType {
    case redo
    case undo
}
