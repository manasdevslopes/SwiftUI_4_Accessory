//
//  TextTips4.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 24/05/23.
//

import SwiftUI

// 4. Set a custom action for links inside Text
struct TextTips4: View {
  var body: some View {
    Text("Hello, world! Check out our [website](https://example.com)!")
      .environment(
        \.openURL,
         OpenURLAction { url in
           print("Link tapped: \(url)")
           return .handled
         }
      )
      .font(.title)
  }
}

struct TextTips4_Previews: PreviewProvider {
  static var previews: some View {
    TextTips4()
  }
}
