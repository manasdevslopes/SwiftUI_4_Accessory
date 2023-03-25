//
//  Podium.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 25/03/23.
//

import SwiftUI

struct Podium: View {
  var body: some View {
    VStack(spacing: 2) {
      ForEach(1..<4) { band($0) }
    }
    .aspectRatio(1.5, contentMode: .fit)
  }
  
  /// Draws one band with rank-specific characteristics.
  private func band(_ rank: Int) -> some View {
    Color.primary.opacity(0.1 * Double(rank))
      .overlay(alignment: .leading) { rankText(rank) }
      .overlay(alignment: .trailing) { rankText(rank) }
  }
  
  /// Draws one rank text indicator.
  private func rankText(_ rank: Int) -> some View {
    Text("\(rank)")
      .font(.system(size: 64))
      .opacity(0.1)
  }
}

/// A SwiftUI preview provider for the podium's background view.
struct Podium_Previews: PreviewProvider {
  static var previews: some View {
    Podium()
  }
}

