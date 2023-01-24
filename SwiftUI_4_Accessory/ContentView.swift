//
//  ContentView.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 06/11/22.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var storeModel = StoreModel()
  
  var body: some View {
//    if #available(iOS 15, *) {
//      NavigationView {
//        AutoOTPTextField()
//          .navigationBarTitleDisplayMode(.inline)
//          .navigationBarHidden(true)
//      }
//    } else {
//      NavigationStack {
//        AutoOTPTextField()
//          .navigationBarTitleDisplayMode(.inline)
//          .toolbar(.hidden, for: .navigationBar)
//      }
//    }
//    NavigationStack {
//      NativePopover()
//    }
    ModelViewViews()
      .environmentObject(storeModel)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

