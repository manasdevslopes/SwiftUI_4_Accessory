//
//  ButtonStack.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 25/03/23.
//

import SwiftUI

struct ButtonStack: View {
  var body: some View {
    ViewThatFits { // Choose the first view that fits.
      MyEqualWidthHStack { // Arrange horizontally if it fits...
        Buttons()
      }
      MyEqualWidthVStack { // ...or vertically, otherwise.
        Buttons()
      }
    }
    //.environment(\.dynamicTypeSize, .accessibility3)
  }
}

private struct Buttons: View {
  @EnvironmentObject private var model: Model
  
  var body: some View {
    ForEach($model.pets) { $pet in
      Button {
        pet.votes += 1
      } label: {
        Text(pet.type)
          .frame(maxWidth: .infinity) // Expand to fill the offered space.
      }
      .buttonStyle(.bordered)
    }
  }
}

/// A SwiftUI preview provider for the voting buttons.
struct ButtonStack_Previews: PreviewProvider {
  static var previews: some View {
    ButtonStack()
      .environmentObject(Model.previewData)
  }
}
