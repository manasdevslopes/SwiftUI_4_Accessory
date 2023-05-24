//
//  TextTips2.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 24/05/23.
//

import SwiftUI

struct TextTips2: View {
  var body: some View {
    VStack(spacing: 20) {
      // From a string literal
      
      Text("Hello, **world**! Check out our [website](https://example.com)!")
      
      
      // From a string variable, explicitly converted to a LocalizedStringKey
      
      let markdownStr = "Hello, **world**! Check out our [website](https://example.com)!"
      Text(LocalizedStringKey(markdownStr))
      
      
      // From an AttributedString (no localization)
      
      if let attrStr = try? AttributedString(markdown: markdownStr) {
        Text(attrStr)
      }
    }
    .font(.title)
  }
}

struct TextTips2_Previews: PreviewProvider {
  static var previews: some View {
    TextTips2()
  }
}
