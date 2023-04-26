//
//  Particle.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 26/04/23.
//

import SwiftUI

struct ParticleEffectModel: Identifiable {
  var id: UUID = .init()
  var randomX: CGFloat = 0
  var randomY: CGFloat = 0
  var scale: CGFloat = 1
  /// Optional
  var opacity: CGFloat = 1
  
  /// Reset's all Properties
  mutating func reset() {
    randomX = 0
    randomY = 0
    scale = 1
    opacity = 1
  }
}
