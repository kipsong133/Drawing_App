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
}
