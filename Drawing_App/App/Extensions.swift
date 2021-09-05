//
//  Extensions.swift
//  Drawing_App
//
//  Created by 김우성 on 2021/09/05.
//

import UIKit

extension UIViewController {
    func logMessage(_ message: String,
                    fileID: String = #fileID,
                    functionName: String = #function,
                    lineNumber: Int = #line
    ) {
        
        print("DEBUG>> \(message) \n-> Called by \(fileID) \n-> \(functionName) at line \(lineNumber)")
    }
    
    
}
