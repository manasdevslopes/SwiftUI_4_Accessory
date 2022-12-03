//
//  Gradients.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 03/12/22.
//

import SwiftUI

struct Gradients: View {
  let colors: [Color] = [.blue, .mint, .green, .yellow, .red, .indigo, .purple]
  
    var body: some View {
      VStack {
        ForEach(colors, id: \.self) { color in
          Rectangle().fill(color.gradient)
        }
      }
    }
}

struct Gradients_Previews: PreviewProvider {
    static var previews: some View {
        Gradients()
    }
}
