//
//  TextTips3.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 24/05/23.
//

import SwiftUI

// 3. Change color of links inside Text
struct TextTips3: View {
    var body: some View {
      Text("Hello, world! Check out our [website](https://example.com)!")
        .tint(.pink)
        .font(.title)
    }
}

struct TextTips3_Previews: PreviewProvider {
    static var previews: some View {
        TextTips3()
    }
}
