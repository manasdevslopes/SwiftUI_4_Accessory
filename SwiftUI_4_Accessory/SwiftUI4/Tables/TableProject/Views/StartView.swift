//
//  StartView.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 28/01/23.
//

import SwiftUI

struct StartView: View {
  var body: some View {
    TabView {
      CountryTableView()
        .tabItem {
          Label("Country TableView", systemImage: "1.circle.fill")
        }
      CountrySplitView()
        .tabItem {
          Label("Country SplitView", systemImage: "2.circle.fill")
        }
    }
  }
}

struct StartView_Previews: PreviewProvider {
  static var previews: some View {
    StartView()
  }
}
