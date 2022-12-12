//
//  Particle.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 12/12/22.
//

import Foundation

struct Particle: Hashable {
  let x: Double
  let y: Double
  let creationDate = Date.now.timeIntervalSinceReferenceDate
  let hue: Double
}
