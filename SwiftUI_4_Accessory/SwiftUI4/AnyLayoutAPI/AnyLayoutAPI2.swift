//
//  AnyLayoutAPI2.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 03/12/22.
//

import SwiftUI

struct AnyLayoutAPI2: View {
  @Environment(\.dynamicTypeSize) var dynamicTypeSize
  
  var body: some View {
    let layout = dynamicTypeSize <= .xxxLarge ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())
    
    layout {
      Image(systemName: "1.circle")
      Image(systemName: "2.circle")
      Image(systemName: "3.circle")
    }
    .font(.largeTitle)
  }
}

struct AnyLayoutAPI2_Previews: PreviewProvider {
  static var previews: some View {
    AnyLayoutAPI2()
  }
}
