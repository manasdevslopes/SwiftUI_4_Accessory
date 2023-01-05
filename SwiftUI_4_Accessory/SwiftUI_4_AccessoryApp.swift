//
//  SwiftUI_4_AccessoryApp.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 06/11/22.
//

import SwiftUI

@main
struct SwiftUI_4_AccessoryApp: App {
  @StateObject var order = Order()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(order)
    }
  }
}
