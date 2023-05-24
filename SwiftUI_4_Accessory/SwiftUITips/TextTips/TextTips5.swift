//
//  TextTips5.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 24/05/23.
//

import SwiftUI

// 5. Text interpolation
struct TextTips5: View {
  var body: some View {
    // Can interpolate text with text modifiers
    Text("Hello, \(Text("world").foregroundColor(.pink))!")
      .font(.title)
  }
}

struct TextTips5_Previews: PreviewProvider {
  static var previews: some View {
    TextTips5()
  }
}
