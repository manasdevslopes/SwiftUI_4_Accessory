//
//  TextTips1.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 24/05/23.
//

import SwiftUI

struct TextTips1: View {
    var body: some View {
      VStack(spacing: 20) {
        // From a String Literal
        Text("Hello, World!") // Text.init(_ key: LocalizedStringKey, tableName: String? = nil, bundle: Bundle? = nil, comment: StaticString? = nil)
        
        
        // From aString variable
        
        var str = "Hello, World!"
        Text(str) // Text.init<S>(_ content: S) where S: StringProtocol
      }
      .font(.title)
    }
}

struct TextTips1_Previews: PreviewProvider {
    static var previews: some View {
        TextTips1()
    }
}
