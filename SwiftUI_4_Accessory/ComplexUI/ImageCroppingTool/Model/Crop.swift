//
//  Crop.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 19/01/23.
//

import Foundation

enum Crop: Equatable {
  case circle
  case rectangle
  case square
  case custom(CGSize)
  
  func name() -> String {
    switch self {
      case .circle:
        return "Circle"
      case .square:
        return "Square"
      case .rectangle:
        return "Rectangle"
      case .custom(let cGSize):
        return "Custom \(Int(cGSize.width))X\(Int(cGSize.height))"
    }
  }
  
  func size()->CGSize {
    switch self {
      case .circle:
        return .init(width: 300, height: 300)
      case .square:
        return .init(width: 300, height: 300)
      case .rectangle:
        return .init(width: 300, height: 500)
      case .custom(let cGSize):
        return cGSize
    }
  }
}
