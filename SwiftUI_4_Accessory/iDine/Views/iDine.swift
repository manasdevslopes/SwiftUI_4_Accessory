//
//  iDine.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 19/12/22.
//

import SwiftUI

struct iDine: View {
  let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(menu) { section in
          Section(section.name) {
            ForEach(section.items) { item in
              ItemRow(item: item)
            }
          }
        }
      }
      .navigationTitle("Menu")
      .listStyle(.grouped)
    }
  }
}

struct iDine_Previews: PreviewProvider {
  static var previews: some View {
    iDine()
  }
}
