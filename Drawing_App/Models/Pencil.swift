//
//  Pencil.swift
//  Drawing_App
//
//  Created by 김우성 on 2021/09/05.
//

import UIKit

enum Pencil {
  case black
  case grey
  case red
  case darkblue
  case lightBlue
  case darkGreen
  case lightGreen
  case brown
  case orange
  case yellow
  case eraser
  
  init?(tag: Int) {
    switch tag { // tag 값으로 색상 구분
    case 1:
      self = .black
    case 2:
      self = .grey
    case 3:
      self = .red
    case 4:
      self = .darkblue
    case 5:
      self = .lightBlue
    case 6:
      self = .darkGreen
    case 7:
      self = .lightGreen
    case 8:
      self = .brown
    case 9:
      self = .orange
    case 10:
      self = .yellow
    case 11:
      self = .eraser
    default:
      return nil
    }
  }
}

