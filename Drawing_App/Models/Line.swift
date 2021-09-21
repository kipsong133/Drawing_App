//
//  Line.swift
//  Drawing_App
//
//  Created by 김우성 on 2021/09/21.
//

import CoreGraphics

struct Line {
    var startPoint: CGPoint
    var endPonint: CGPoint
    
    init(_ start: CGPoint, _ end: CGPoint) {
        self.startPoint = start
        self.endPonint = end
    }
}
