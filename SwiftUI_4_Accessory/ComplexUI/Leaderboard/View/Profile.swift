//
//  Profile.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 25/03/23.
//

import SwiftUI

struct Profile: View {
  @EnvironmentObject private var model: Model
 
  var body: some View {
    // Use a horizontal layout for a tie; use a radial layout, otherwise.
    let layout = model.isAllWayTie ? AnyLayout(HStackLayout()) : AnyLayout(MyRadialLayout())
    
    Podium()
      .overlay(alignment: .top) {
        layout {
          ForEach(model.pets) { pet in
            Avatar(pet: pet)
              .rank(model.rank(pet))
          }
        }
        .animation(.default, value: model.pets)
      }
  }
}

/// A SwiftUI preview provider for the view that shows the ranked, pet avatars.
struct Profile_Previews: PreviewProvider {
  static var previews: some View {
    Profile()
      .environmentObject(Model.previewData)
  }
}
