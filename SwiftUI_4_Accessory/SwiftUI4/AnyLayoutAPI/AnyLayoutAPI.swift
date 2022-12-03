//
//  AnyLayoutAPI.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 03/12/22.
//

import SwiftUI

struct AnyLayoutAPI: View {
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  
    var body: some View {
      let layout = horizontalSizeClass == .regular ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())
      
      layout {
        Image(systemName: "1.circle")
        Image(systemName: "2.circle")
        Image(systemName: "3.circle")
      }
      .font(.largeTitle)
    }
}

struct AnyLayoutAPI_Previews: PreviewProvider {
    static var previews: some View {
        AnyLayoutAPI()
    }
}
