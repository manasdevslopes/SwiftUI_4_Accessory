//
//  NavigationAPI.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 24/11/22.
//

import SwiftUI

struct NavigationStackAPI: View {
  // MARK: - if want to show some pages from List before main page
  // @State private var presentedNumbers = [1, 4, 8]
  @State private var presentedNumbers = NavigationPath()
  
  var body: some View {
    NavigationStack(path: $presentedNumbers) {
      NavigationLink(value: "Example String") {
        Text("Tap Me")
      }
      
      List(1..<50) { i in
        NavigationLink(value: i) {
          Label("Row \(i)", systemImage: "\(i).circle")
        }
      }
      .navigationDestination(for: Int.self) { i in
        Text("Detail \(i)")
      }
      .navigationDestination(for: String.self) { s in
        Text("String: \(s)")
      }
      .navigationTitle("Navigation")
    }
  }
}

struct NavigationAPI_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStackAPI()
  }
}
