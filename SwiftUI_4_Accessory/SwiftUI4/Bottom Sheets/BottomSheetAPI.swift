//
//  BottomSheetAPI.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 24/11/22.
//

import SwiftUI

struct BottomSheetAPI: View {
  @State private var showingCredits:Bool = false
  
  var body: some View {
    Button("Show Credits") {
      showingCredits.toggle()
    }
    .sheet(isPresented: $showingCredits) {
      Text("This app was brought to you from Apple  Developer Center.")
        // .presentationDetents([.medium, .large])
        // .presentationDragIndicator(.hidden)
        // .presentationDetents([.height(300)])
        .presentationDetents([.fraction(0.3)])
    }
  }
}

struct BottomSheetAPI_Previews: PreviewProvider {
  static var previews: some View {
    BottomSheetAPI()
  }
}
