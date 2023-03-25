//
//  Avatar.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 25/03/23.
//

import SwiftUI

struct Avatar: View {
  var pet: Pet
  
  var body: some View {
    Circle()
      .frame(width: 80, height: 80).foregroundColor(pet.color).shadow(radius: 3)
      .overlay {
        Text(pet.type.prefix(1).capitalized) // Use the first letter.
          .font(.system(size: 64))
      }
  }
}

/// A SwiftUI preview provider for the avatar view.
struct Avatar_Previews: PreviewProvider {
  static var previews: some View {
    HStack(spacing: 20) {
      ForEach(Model.previewData.pets) { pet in
        Avatar(pet: pet)
      }
    }
  }
}
