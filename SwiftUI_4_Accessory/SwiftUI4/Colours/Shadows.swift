//
//  Shadows.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 03/12/22.
//

import SwiftUI

struct Shadows: View {
    var body: some View {
      VStack {
        Circle()
          .fill(.red.shadow(.drop(color: .black, radius: 20)))
        Circle()
          .fill(.red.gradient.shadow(.drop(color: .black, radius: 20)))
        Circle()
          .fill(.red.shadow(.inner(color: .black, radius: 20)))
        Circle()
          .fill(.red.gradient.shadow(.inner(color: .black, radius: 20)))
      }
        .padding()
    }
}

struct Shadows_Previews: PreviewProvider {
    static var previews: some View {
        Shadows()
    }
}
